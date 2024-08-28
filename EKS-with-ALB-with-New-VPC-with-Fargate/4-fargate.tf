resource "aws_iam_role" "default-fargate" {
  name = "hunter-eks-fargate-profile"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "hunter-AmazonEKSFargatePodExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.default-fargate.name
}

resource "aws_eks_fargate_profile" "fp-default" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-default"
  pod_execution_role_arn = aws_iam_role.default-fargate.arn
  subnet_ids             = module.vpc.private_subnets

  selector {
    namespace = "kube-system"
  }
  selector {
    namespace = "default"
  }
}