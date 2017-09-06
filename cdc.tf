#
# The EventuateIO Change Data Capture (CDC) service
#

resource "kubernetes_service" "cdc" {
  metadata {
    name = "${var.name}-eventuateio-cdc"
  }

  spec {
    selector {
      app = "${kubernetes_replication_controller.cdc.spec.0.selector.app}"
    }

    port {
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_replication_controller" "cdc" {
  metadata {
    name = "${var.name}-eventuateio-cdc"

    labels {
      app = "${var.name}-eventuateio-cdc-service"
    }
  }

  spec {
    replicas = "${var.cdc_service_scale}"

    selector {
      app = "${var.name}-eventuateio-cdc-service"
    }

    template {
      container {
        image = "eventuateio/eventuateio-local-cdc-service:${var.eventuateio_local_version}"
        name  = "cdc"

        port {
          container_port = 8080
        }

        env {
          name  = "SPRING_DATASOURCE_URL"
          value = "jdbc:mysql://${kubernetes_service.mysql.spec.0.cluster_ip}:3306/eventuate"
        }

        env {
          name  = "SPRING_DATASOURCE_USERNAME"
          value = "mysqluser"
        }

        env {
          name  = "SPRING_DATASOURCE_PASSWORD"
          value = "mysqlpw"
        }

        env {
          name  = "SPRING_DATASOURCE_DRIVER_CLASS_NAME"
          value = "com.mysql.jdbc.Driver"
        }

        env {
          name  = "EVENTUATELOCAL_KAFKA_BOOTSTRAP_SERVERS"
          value = "${kubernetes_service.kafka.spec.0.cluster_ip}:9092"
        }

        env {
          name  = "EVENTUATELOCAL_ZOOKEEPER_CONNECTION_STRING"
          value = "${kubernetes_service.zookeeper.spec.0.cluster_ip}:2181"
        }

        env {
          name  = "EVENTUATELOCAL_CDC_DB_USER_NAME"
          value = "root"
        }

        env {
          name  = "EVENTUATELOCAL_CDC_DB_PASSWORD"
          value = "rootpassword"
        }
      }
    }
  }
}
