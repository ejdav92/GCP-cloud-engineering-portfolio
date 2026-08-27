variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region_primary" {
  description = "Primary deployment region"
  type        = string
  default     = "us-central1"
}

variable "region_secondary" {
  description = "Secondary deployment region"
  type        = string
  default     = "us-east4"
}
