FROM eventuateio/eventuateio-local-kafka:VERSION
ADD run-kafka-patch.sh /usr/local/run-kafka-patch.sh
CMD /usr/local/run-kafka-patch.sh
