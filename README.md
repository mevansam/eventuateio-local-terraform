# Eventuate.IO Services

## Overview

This [Terraform](https://www.terraform.io/) module deploys an [EnventuateIO Local](https://github.com/hashicorp/vault) environment to a target Kubernetes environment.

## Usage

To use this module use the following HCL snippet as an example. 

```
#
# Eventuate IO Local Deployment
#

module "eventuateio-todolist" {
  source = "https://github.com/mevansam/eventuateio-local-terraform.git"

  name                      = "<MY-APP-NAME>"
  eventuateio_local_version = "0.13.0"
}
```

### Inputs

The following variables are supported.

* name - (Type: String, Required) A unique name identifying this deployment.

* eventuateio_local_version - (Type: String, Required) The version of the eventuateio local images to be deployed to the cluster.

* cdc_service_scale - (Type: String, Optional) The scale of the Change Data Capture service. Defaults to 1.

* zookeeper_service_scale - (Type: String, Optional) The scale of the zookeeper cluster.

* kafka_service_scale - (Type: String, Optional) The scale of the kafka cluster.

### Outputs

* mysql_service_port - The port on the cluster for the launched MySQL instance.

* zookeeper_service_port - The client port on the cluster for the launched Zookeeper instance.

* kafka_service_port - The port on the cluster for the launched Kafka instance.
