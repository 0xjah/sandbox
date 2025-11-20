FROM debian:stable

RUN apt-get update && apt-get install -y \
    chromium \
    ca-certificates \
    && useradd -m ahmad \
    && mkdir -p /home/ahmad/.config/chromium \
    && chown -R ahmad:ahmad /home/ahmad

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER ahmad
ENV HOME=/home/ahmad

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["chromium", "--headless", "--disable-gpu", "--no-sandbox"]
