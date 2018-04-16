#!/bin/bash

echo "${ZOOKEEPER}"

if [ -n "${ZOOKEEPER}" ]; then
  echo "change zookeeper address"
  sed -i "/zookeeper.connect=/c zookeeper.connect=${ZOOKEEPER}" /kafka/config/server.properties
else
  echo "keep default zookeeper address"
fi

cat /kafka/config/server.properties

#sed -i "s|{{ZOOKEEPER}}|${ZOOKEEPER}|g" /kafka/config/server.properties

exec /kafka/bin/kafka-server-start.sh /kafka/config/server.properties
