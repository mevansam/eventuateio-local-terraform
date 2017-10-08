#! /bin/bash -e

if [[ -n ${ADVERTISED_PORT} ]]; then
  echo "Updating Kafka advertised port to: ${ADVERTISED_PORT}"
  sed -i -e "s|^\(advertised.listeners=.*\):9092|\1:${ADVERTISED_PORT}|" /usr/local/kafka-config/server.properties
fi

KAFKA_DIR=$(ls -l /usr/local/ | grep kafka_ | awk '{ print $9 }')

cd /usr/local/$KAFKA_DIR
./run-kafka.sh
