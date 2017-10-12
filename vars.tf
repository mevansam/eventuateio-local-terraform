#
# Module inputs
#

variable "name" {
  description = "A unique name identifying this deployment."
  type        = "string"
}

variable "kubo_services_name" {
  description = "The service domain name where Kubernetes services of type 'NodePort' will be available."
  type        = "string"
}

variable "eventuateio_local_version" {
  description = "The version of the eventuateio local images to be deployed to the cluster."
  type        = "string"
}

variable "console_service_image" {
  description = "The Docker Hub image path for the console service."
  default     = "eventuateio/eventuateio-local-console"
}

variable "console_service_scale" {
  description = "The scale of the Console service"
  default     = "1"
}

variable "cdc_service_image" {
  description = "The Docker Hub image path for the Change Data Capture service."
  default     = "eventuateio/eventuateio-local-cdc-service"
}

variable "cdc_service_scale" {
  description = "The scale of the Change Data Capture service"
  default     = "1"
}

variable "zookeeper_service_image" {
  description = "The Docker Hub image path for the Zookeeper service."
  default     = "eventuateio/eventuateio-local-zookeeper"
}

variable "zookeeper_service_scale" {
  description = "The scale of the zookeeper cluster"
  default     = "1"
}

variable "kafka_service_image" {
  description = "The Docker Hub image path for the Kafka service."
  default     = "mevansam/eventuateio-local-kafka"
}

variable "kafka_service_scale" {
  description = "The scale of the kafka cluster"
  default     = "1"
}

variable "mysql_service_image" {
  description = "The Docker Hub image path for the MySQL service."
  default     = "eventuateio/eventuateio-local-mysql"
}

variable "mysql_root_password" {
  description = "The root password for the MySQL server."
  default     = "rootpassword"
}

variable "mysql_app_user_passwd" {
  description = "The application user's password for the Eventuate MySQL service."
  default     = "mysqlpw"
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
