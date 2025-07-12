variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "medusa"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "medusa_image" {
  description = "Medusa Docker image"
  type        = string
  default     = "medusajs/medusa:latest"
}

variable "cpu" {
  description = "CPU units for the task"
  type        = number
  default     = 512
}

variable "memory" {
  description = "Memory for the task"
  type        = number
  default     = 1024
}

variable "desired_count" {
  description = "Desired number of tasks"
  type        = number
  default     = 1
}