#
# The EventuateIO MySQL service
#

resource "kubernetes_service" "mysql" {
  metadata {
    name = "${var.name}-eventuateio-mysql"
  }

  spec {
    selector {
      app = "${var.name}-eventuateio-mysql-service"
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
        image = "${var.mysql_service_image}:${var.eventuateio_local_version}"
        name  = "mysql"

        port {
          container_port = 3306
        }

        env {
          name  = "MYSQL_ROOT_PASSWORD"
          value = "${var.mysql_root_password}"
        }

        env {
          name  = "MYSQL_USER"
          value = "mysqluser"
        }

        env {
          name  = "MYSQL_PASSWORD"
          value = "${var.mysql_app_user_passwd}"
        }
      }
    }
  }
}
