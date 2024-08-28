# EKS-with-ALB-with-Default-VPC

## Prerequisite

First, install the AWS CLI and kubectl command. Then, configure the AWS CLI with your access and secret keys.

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version
```

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/bin/
kubectl version --client
```

To configure the AWS CLI, run the following command.

```bash
aws configure
```

## Configure the structure with Terraform
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

After successfully deploying with Terraform, Run the following command with your EKS cluster name to configure the kubectl and restart the deployment.

```bash
aws eks update-kubeconfig --name EKS-CLUSTER-NAME --region ap-south-1
```

Now deploy a simple nginx docker image in Kuberntes.

```bash
kubectl apply -f demo-deployment.yaml
```

## Destroy the structure with Terraform

First delete the demo deployment which we have deployed in the above commands.
```bash
kubectl delete -f demo-deployment.yaml
```

To delete the structure created by Terraform.

```bash
terraform destroy --auto-approve
```

## Note :-
Before executing the `terraform destroy` command, ensure that all deployments and ingress resources are deleted. If these resources are not removed beforehand, the Application Load Balancer (ALB) connected to the EKS cluster may fail to delete, potentially leading to errors during the terraform deletion process in `terraform destroy` command. In such cases, you would need to manually delete the ALB to resolve the issue.
