#!/bin/sh
mkdir -p /var/log/sandbox
tcpdump -i any -w /var/log/sandbox/capture.pcap
