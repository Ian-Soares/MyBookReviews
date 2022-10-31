variable "cluster_name" {
  description = "The cluster_name"
}

variable "app_repository_name" {
  description = "ECR Repository name"
}

variable "git_repository_name" {
  description = "Name of repository"
}

variable "git_repository_branch" {
  description = "Build branch aka Master"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "repository_url" {
  description = "The url of the ECR repository"
}

variable "subnet_ids" {
  type        = list(any)
  description = "Subnet ids"
}

variable "region" {
  description = "The region to use"
}

variable "container_name" {
  description = "Container name"
}

variable "account_id" {
  description = "AWS Account ID"
}

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key ID for CodeBuild"
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Access Key for CodeBuild"
}

variable "AWS_SESSION_TOKEN" {
  description = "AWS Session Token for CodeBuild"
}

variable "MONGO_USER" {
  description = "MongoDB User"
}

variable "MONGO_PASSWD" {
  description = "MongoDB Password"
}