# EKS-with-ALB-with-New-VPC-with-Fargate

Execute the following command to create the structure using Terraform.

```bash
terraform init
terraform plan
terraform apply --auto-approve
```

The Terraform deployment might fail at the Helm section. Redeploy it using the following command.

```bash
terraform apply --auto-approve
```

After successfully deploying with Terraform, install the AWS CLI and kubectl, then configure them. Once configured, run the following command using your EKS cluster name.

```bash
aws eks update-kubeconfig --name EKS-CLUSTER-NAME --region ap-south-1
kubectl rollout restart deployment coredns -n kube-system
```

To delete the structure created by Terraform.

```bash
terraform destroy --auto-approve
```

## Note :-
When deleting Terraform resources, ensure to manually delete the load balancer associated with the EKS cluster. In some cases, Terraform may not be able to delete the VPC created for EKS, so you may need to manually delete the VPC as well.
