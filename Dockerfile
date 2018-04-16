FROM openjdk:8u151-jre-alpine

MAINTAINER konstantins304 <konstantins304@gmail.com> 

RUN apk add --no-cache bash curl jq docker

RUN mkdir /kafka /data /logs

ADD start.sh /tmp/start.sh
ADD kafka_2.12-1.1.0 /tmp/kafka_2.12-1.1.0

WORKDIR /tmp

RUN mv kafka_2.12-1.1.0/* /kafka/ && \
    mv start.sh /kafka/start.sh && \
    chmod +x /kafka/start.sh

RUN addgroup kafka && \
    adduser -D -h /kafka -G kafka kafka && \
    chown -R kafka:kafka /kafka /data /logs

USER kafka
ENV PATH=$PATH:/kafka/bin
WORKDIR /kafka

EXPOSE 9092

VOLUME [ "/data", "/logs" ]

CMD ["/kafka/start.sh"]
