variable "AWS-Region" {
  default = "ap-south-1"
}

variable "AWS-Access-Key" {
  default = "access-key-value"
}

variable "AWS-Secret-Key" {
  default = "secret-key-value"
}

variable "cluster_name" {
  default = "Hunter-EKS"
}

variable "cluster_version" {
  default = "1.30"
}

variable "VPC-Name" {
  default = "Hunter-VPC"
}

output "combined_output_list" {
  value = ["AWS-Region = ${var.AWS-Region}", "AWS-Access-Key = ${var.AWS-Access-Key}", "AWS-Secret-Key = ${var.AWS-Secret-Key}", "EKS-Name = ${var.cluster_name}"]
}

output "output_list" {
  value = [
    "To restart CoreDNS, run the following commands:",
    "aws eks update-kubeconfig --name ${var.cluster_name} --region ${var.AWS-Region}",
    "kubectl rollout restart deployment coredns -n kube-system"
  ]
}
