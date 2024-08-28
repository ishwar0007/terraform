# EKS-with-ALB-with-New-VPC-with-Fargate
Terraform deployment may fails at helm section, Redeploy the terraform deployment

After Successful Terraform deployment, Install AWS Cli, kubectl and configure them. After that, run the following command as per your EKS Cluster name.
aws eks update-kubeconfig --name Hunter-EKS --region ap-south-1
kubectl rollout restart deployment coredns -n kube-system

To Delete
terraform destroy --auto-approve

When you are deleting the terraform resources at that time make sure to manaully delete the loadbalancer associated to the EKS. In some cases terraform will not be able to delete VPC created for EKS, then you need to manually delete the VPC.
