variable "AWS-Region" {
  default = "ap-south-1"
}

variable "AWS-Access-Key" {
  default = "access-key-value"
}

variable "AWS-Secret-Key" {
  default = "secret-key-value"
}

variable "EKS-Name" {
  default = "Hunter-EKS"
}
EKS-Version

variable "EKS-Version" {
  default = "1.30"
}

output "combined_output_list" {
  value = ["AWS-Region = ${var.AWS-Region}", "AWS-Access-Key = ${var.AWS-Access-Key}", "AWS-Secret-Key = ${var.AWS-Secret-Key}", "EKS-Name = ${var.EKS-Name}"]
}
