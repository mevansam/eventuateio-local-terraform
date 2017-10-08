#
# The EventuateIO Zookeeper service
#

resource "kubernetes_service" "zookeeper" {
  metadata {
    name = "${var.name}-eventuateio-zookeeper"
  }

  spec {
    selector {
      app = "${var.name}-eventuateio-zookeeper-service"
    }

    port {
      name        = "clientport"
      port        = 2181
      target_port = 2181
    }

    port {
      name        = "peerport"
      port        = 2888
      target_port = 2888
    }

    port {
      name        = "leaderport"
      port        = 3888
      target_port = 3888
    }

    type = "NodePort"
  }
}

resource "kubernetes_replication_controller" "zookeeper" {
  metadata {
    name = "${var.name}-eventuateio-zookeeper"

    labels {
      app = "${var.name}-eventuateio-zookeeper-service"
    }
  }

  spec {
    replicas = "${var.zookeeper_service_scale}"

    selector {
      app = "${var.name}-eventuateio-zookeeper-service"
    }

    template {
      container {
        image = "${var.zookeeper_service_image}:${var.eventuateio_local_version}"
        name  = "zookeeper"

        port {
          container_port = 2181
        }

        port {
          container_port = 2888
        }

        port {
          container_port = 3888
        }
      }
    }
  }
}
