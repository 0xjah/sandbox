#!/bin/sh
# Simple logger entrypoint for the logger container.
#
# Behavior:
# - Writes a raw pcap using `tcpdump` to `$OUT_DIR/capture.pcap`.
# - Writes a live JSON parsed stream using `tshark` to `$OUT_DIR/packets.json`.
# - Both processes are run in parallel and are terminated on container stop.

set -eu

OUT_DIR=${OUT_DIR:-/var/log/sandbox}
INTERFACE=${INTERFACE:-any}
PCAP_FILE=${PCAP_FILE:-$OUT_DIR/capture.pcap}
JSON_FILE=${JSON_FILE:-$OUT_DIR/packets.json}

# Use separate capture (BPF) and display (tshark) filters if needed
PCAP_FILTER=${PCAP_FILTER:-}
TSHARK_DISPLAY_FILTER=${TSHARK_DISPLAY_FILTER:-}

mkdir -p "$OUT_DIR"

echo "[logger] starting capture"
echo "[logger] interface=$INTERFACE pcap=$PCAP_FILE json=$JSON_FILE"

kill_children() {
	echo "[logger] stopping..."
	[ -n "${TCPDUMP_PID:-}" ] && kill "${TCPDUMP_PID}" 2>/dev/null || true
	[ -n "${TSHARK_PID:-}" ] && kill "${TSHARK_PID}" 2>/dev/null || true
}

trap 'kill_children; exit 0' TERM INT

# Rotation options (size in MB and number of files)
ROTATE_SIZE_MB=${ROTATE_SIZE_MB:-0}
ROTATE_FILES=${ROTATE_FILES:-0}

# Start tcpdump to write raw pcap. If rotation is requested, use -C and -W.
if [ "$ROTATE_SIZE_MB" -gt 0 ] && [ "$ROTATE_FILES" -gt 0 ]; then
	# When rotating, tcpdump will append numeric suffixes to the filename.
	TCMD="tcpdump -i $INTERFACE -w $PCAP_FILE -U -C $ROTATE_SIZE_MB -W $ROTATE_FILES"
else
	TCMD="tcpdump -i $INTERFACE -w $PCAP_FILE -U"
fi
if [ -n "$PCAP_FILTER" ]; then
	TCMD="$TCMD $PCAP_FILTER"
fi
sh -c "$TCMD" >/dev/null 2>&1 &
TCPDUMP_PID=$!

# Start tshark to write JSON (line-buffered) for easier consumption
# Use -n to avoid DNS lookups and -l to make output line-buffered
TS_CMD="tshark -i $INTERFACE -T json -l -n"
if [ -n "$TSHARK_DISPLAY_FILTER" ]; then
	TS_CMD="$TS_CMD -Y \"$TSHARK_DISPLAY_FILTER\""
fi
sh -c "$TS_CMD" > "$JSON_FILE" 2>&1 &
TSHARK_PID=$!

echo "[logger] tcpdump pid=$TCPDUMP_PID tshark pid=$TSHARK_PID"

# Wait on child processes; exit when both have exited
while true; do
	if ! kill -0 "$TCPDUMP_PID" 2>/dev/null; then
		echo "[logger] tcpdump exited"
		kill_children
		break
	fi
	if ! kill -0 "$TSHARK_PID" 2>/dev/null; then
		echo "[logger] tshark exited"
		kill_children
		break
	fi
	sleep 1
done

wait

echo "[logger] finished"
