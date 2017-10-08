#
# The EventuateIO Console service
#

resource "kubernetes_service" "console" {
  metadata {
    name = "${var.name}-eventuateio-console"
  }

  spec {
    selector {
      app = "${kubernetes_replication_controller.console.spec.0.selector.app}"
    }

    port {
      port        = 8085
      target_port = 8080
    }

    type = "NodePort"
  }
}

resource "kubernetes_replication_controller" "console" {
  metadata {
    name = "${var.name}-eventuateio-console"

    labels {
      app = "${var.name}-eventuateio-console"
    }
  }

  spec {
    replicas = "${var.console_service_scale}"

    selector {
      app = "${var.name}-eventuateio-console"
    }

    template {
      container {
        image = "${var.console_service_image}:${var.eventuateio_local_version}"
        name  = "console"

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
          name  = "EVENTUATELOCAL_ZOOKEEPER_CONNECTION_STRING"
          value = "${kubernetes_service.zookeeper.spec.0.cluster_ip}:2181"
        }

        env {
          name  = "DEBUG"
          value = "kafka-node:*"
        }
      }
    }
  }
}
