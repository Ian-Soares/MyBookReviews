module "vpc" {
  source = "./modules/vpc"

  tags                    = var.tags
  instance_tenancy        = "default"
  vpc_cidr                = var.vpc_cidrblock
  access_ip               = var.access_ip
  public_subnet_count     = 2
  public_cidrs            = var.public_cidrs
  private_subnet_count    = 2
  private_cidrs           = var.private_cidrs
  map_public_ip_on_launch = true
  rt_route_cidr_block     = "0.0.0.0/0"
  vpc_name                = var.vpc_name
}

module "eks" {
  source = "./modules/eks"

  aws_public_subnet       = module.vpc.aws_public_subnet
  vpc_id                  = module.vpc.vpc_id
  scaling_desired_size    = var.eks_size["desired_size"]
  scaling_max_size        = var.eks_size["maximum_size"]
  scaling_min_size        = var.eks_size["minimum_size"]
  instance_types          = var.instance_types
  cluster_name            = var.cluster_name
  tags                    = var.tags
  endpoint_public_access  = true
  endpoint_private_access = false
  public_access_cidrs     = ["0.0.0.0/0"]
  node_group_name         = var.node_group_name
  iam_role_name           = var.iam_role_name
  node_iam_role           = var.node_group_name
  ecr_name                = var.api_ecr_name
  owner                   = var.owner
  department              = var.department
  environment             = var.environment
}

module "pipeline" {
  source                = "./modules/pipeline"
  repository_url        = module.eks.repository_url
  region                = var.aws_region
  vpc_id                = module.vpc.vpc_id
  account_id            = data.aws_caller_identity.current.account_id
  cluster_name          = var.cluster_name
  container_name        = var.container_name
  app_repository_name   = var.api_ecr_name
  git_repository_name   = var.git_repository_name
  git_repository_branch = var.git_repository_branch
  AWS_ACCESS_KEY_ID     = var.AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
  AWS_SESSION_TOKEN     = var.AWS_SESSION_TOKEN

  subnet_ids = [
    module.vpc.private_subnet_1a,
    module.vpc.private_subnet_1b
  ]
}