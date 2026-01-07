variable "project_id" {
  description = "Control Plane GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "us-central1-a"
}

variable "vm_name" {
  description = "Bindplane control plane VM name"
  type        = string
  default     = "bindplane-control"
}

variable "machine_type" {
  description = "VM machine type"
  type        = string
  default     = "e2-standard-4"
}
