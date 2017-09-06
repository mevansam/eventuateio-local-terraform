#
# The EventuateIO MySQL service
#

resource "kubernetes_service" "mysql" {
  metadata {
    name = "${var.name}-eventuateio-mysql"
  }

  spec {
    selector {
      app = "${kubernetes_replication_controller.mysql.spec.0.selector.app}"
    }

    port {
      port        = 3306
      target_port = 3306
    }

    type = "NodePort"
  }
}

resource "kubernetes_replication_controller" "mysql" {
  metadata {
    name = "${var.name}-eventuateio-mysql"

    labels {
      app = "${var.name}-eventuateio-mysql-service"
    }
  }

  spec {
    selector {
      app = "${var.name}-eventuateio-mysql-service"
    }

    template {
      container {
        image = "eventuateio/eventuateio-local-mysql:${var.eventuateio_local_version}"
        name  = "mysql"

        port {
          container_port = 3306
        }

        env {
          name  = "MYSQL_ROOT_PASSWORD"
          value = "rootpassword"
        }

        env {
          name  = "MYSQL_USER"
          value = "mysqluser"
        }

        env {
          name  = "MYSQL_PASSWORD"
          value = "mysqlpw"
        }
      }
    }
  }
}
