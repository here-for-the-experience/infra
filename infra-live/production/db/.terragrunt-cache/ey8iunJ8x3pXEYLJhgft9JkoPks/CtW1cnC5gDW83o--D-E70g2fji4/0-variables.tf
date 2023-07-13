
variable "env" {
  description = "Environment name."
  type        = string
}


variable "vpc_id" {
  description = "VPC Id"
  type        = string
}

variable "db_password" {
  description = "VPC Id"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs. Must be in at least two different availability zones."
  type        = list(string)
}

