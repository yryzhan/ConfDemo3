variable "credentials" {
  description = "CREDENTIALS_JSON_PATH"
  default = "/var/lib/jenkins/credential/if-101-demo1-02c2a2eae285.json"
}

variable "region" {
  description = "Region"
  default     = "us-east1"
}

variable "project" {
  description = "Project ID"
  default     = "if-101-demo1"
}

variable "network" {
  description = "The name or self_link of the network to attach this interface to. Either network or subnetwork must be provided."
  default     = "default"
}

variable "subnetwork" {
  description = "The name or self_link of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided."
  default     = ""
}

variable "subnetwork_project" {
  description = "The project in which the subnetwork belongs. If the subnetwork is a self_link, this field is ignored in favor of the project defined in the subnetwork self_link. If the subnetwork is a name and this field is not provided, the provider project is used."
  default     = ""
}


