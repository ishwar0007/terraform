# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get the subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Set Tags to default subnets
resource "aws_default_subnet" "default_az1" {
  availability_zone = "ap-south-1a"

  tags = {
    "kubernetes.io/cluster/${var.EKS-Name}" = "shared"
    "kubernetes.io/role/elb"                   = "1"
  }
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = "ap-south-1b"

  tags = {
    "kubernetes.io/cluster/${var.EKS-Name}" = "shared"
    "kubernetes.io/role/elb"                   = "1"
  }
}

resource "aws_default_subnet" "default_az3" {
  availability_zone = "ap-south-1c"

  tags = {
    "kubernetes.io/cluster/${var.EKS-Name}" = "shared"
    "kubernetes.io/role/elb"                   = "1"
  }
}

# EKS Cluster module
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = var.EKS-Name
  cluster_version = var.EKS-Version

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access  = false
  enable_cluster_creator_admin_permissions = true

  vpc_id     = data.aws_vpc.default.id
  subnet_ids = data.aws_subnets.default.ids
  control_plane_subnet_ids = data.aws_subnets.default.ids

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    one = {
      name = "${var.EKS-Name}-node-group"
      instance_types = ["t3.small"]
      min_size     = 1
      max_size     = 3
      desired_size = 1
    }
  }
}
