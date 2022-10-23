variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-2"
  type        = string
}

variable "access_ip" {
  description = "IP that can access resources"
  default     = "0.0.0.0/0"
  type        = string
}

variable "vpc_cidrblock" {
  description = "VPC CIDR Block"
  default     = "10.0.0.0/16"
  type        = string
}

variable "vpc_name" {
  type    = string
  default = "vpc_labs"
}

variable "public_cidrs" {
  description = "Public subnets CIDR Block"
  default     = ["10.0.0.0/20", "10.0.16.0/20"]
  type        = list(any)
}

variable "private_cidrs" {
  description = "Public subnets CIDR Block"
  default     = ["10.0.32.0/20", "10.0.48.0/20"]
  type        = list(any)
}

variable "eks_size" {
  description = "EKS desired size"
  type        = map(any)
  default = {
    "minimum_size" = 1,
    "desired_size" = 2,
    "maximum_size" = 3
  }
}

variable "node_group_name" {
  description = "Node group name"
  type        = string
  default     = "ian-node-group"
}

variable "cluster_name" {
  description = "Cluster name"
  type        = string
  default     = "ian-eks-cluster"
}

variable "instance_types" {
  description = "Instance types (t3.small, m5.large etc...)"
  type        = list(any)
  default     = ["t3.small"]
}

variable "owner" {
  description = "Owner name"
  type        = string
  default     = "iansoares"
}

variable "department" {
  description = "Department name"
  type        = string
  default     = "Sust"
}

variable "environment" {
  description = "Project name"
  type        = string
  default     = "labEksPrometheusGrafana"
}

variable "tags" {
  description = "Resource tags"
  type        = map(any)
  default = {
    Owner       = "iansoares",
    Department  = "Sust",
    Environment = "labEksPrometheusGrafana"
  }
}

variable "api_ecr_name" {
  description = "API ECR Repository"
  type        = string
  default     = "api-lab-eks-ian"
}

variable "iam_role_name" {
  default = "eks_lab_iam_role"
  type    = string
}

variable "node_iam_role" {
  default = "eks_lab_node_role"
  type    = string
}

variable "git_repository_name" {
  description = "Project name on Github"
  default     = "ian-soares/MyBookReviews"
}

variable "git_repository_branch" {
  description = "Github Project Branch"
  default     = "main"
}

variable "container_name" {
  description = "Container app name"
  default     = "mbr_api"
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