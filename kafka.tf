#
# The EventuateIO Kafka service
#

resource "kubernetes_service" "kafka" {
  metadata {
    name = "${var.name}-eventuateio-kafka"
  }

  spec {
    selector {
      app = "${var.name}-eventuateio-kafka-service"
    }

    port {
      port        = 9092
      target_port = 9092
    }

    type = "NodePort"
  }
}

resource "kubernetes_replication_controller" "kafka" {
  metadata {
    name = "${var.name}-eventuateio-kafka"

    labels {
      app = "${var.name}-eventuateio-kafka-service"
    }
  }

  spec {
    replicas = "${var.kafka_service_scale}"

    selector {
      app = "${var.name}-eventuateio-kafka-service"
    }

    template {
      container {
        image = "${var.kafka_service_image}:${var.eventuateio_local_version}"
        name  = "kafka"

        port {
          container_port = 9092
        }

        env {
          name  = "ADVERTISED_HOST_NAME"
          value = "${var.kubo_services_name}"
        }

        env {
          name  = "ADVERTISED_PORT"
          value = "${kubernetes_service.kafka.spec.0.port.0.node_port}"
        }

        env {
          name  = "KAFKA_HEAP_OPTS"
          value = "-Xmx320m -Xms320m"
        }

        env {
          name  = "ZOOKEEPER_SERVERS"
          value = "${kubernetes_service.zookeeper.spec.0.cluster_ip}:2181"
        }
      }
    }
  }
}
