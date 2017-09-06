#
# Module inputs
#

variable "name" {
  description = "A unique name identifying this deployment."
  type        = "string"
}

variable "eventuateio_local_version" {
  description = "The version of the eventuateio local images to be deployed to the cluster."
  type        = "string"
}

variable "cdc_service_scale" {
  description = "The scale of the Change Data Capture service"
  default     = "1"
}

variable "zookeeper_service_scale" {
  description = "The scale of the zookeeper cluster"
  default     = "1"
}

variable "kafka_service_scale" {
  description = "The scale of the kafka cluster"
  default     = "1"
}

output "mysql_service_port" {
  value = "${kubernetes_service.mysql.spec.0.port.0.node_port}"
}

output "zookeeper_service_port" {
  value = "${kubernetes_service.zookeeper.spec.0.port.0.node_port}"
}

output "kafka_service_port" {
  value = "${kubernetes_service.kafka.spec.0.port.0.node_port}"
}
