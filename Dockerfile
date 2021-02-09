FROM ubuntu:20.10 as builder

RUN apt-get update \
 && apt-get install --no-install-recommends -y  \
       ca-certificates \
       git \
 && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git config --global http.sslCAinfo /etc/ssl/certs/ca-certificates.crt \
 && git clone https://github.com/inAudible-NG/tables.git

COPY aax_2_m4b.sh /tables

RUN chmod +x /tables/aax_2_m4b.sh

FROM ivonet/mediatools:latest

RUN apt-get update \
 && apt-get install --no-install-recommends -y  \
       jq \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=builder /tables /rcrack
WORKDIR /rcrack

ENTRYPOINT ["./aax_2_m4b.sh"]


