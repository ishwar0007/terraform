# Creating EC2 Instance
resource "aws_instance" "web" {
  count = var.Instance-Number
  ami           = "ami-05e00961530ae1b55"           # Ubuntu 22.04
  instance_type = "t2.micro"
  key_name      = "Hunter"
  vpc_security_group_ids = ["sg-081972c2c05299b92"]

  root_block_device {
    volume_size           = 20 # Adjust volume size in GB
    delete_on_termination = true
  }

  tags = {
    Name = "Terraform-${count.index}"
  }
}

# Allocating new Elastic IPs and assigning them to the newly created instances
resource "aws_eip" "lb" {
  count  = var.Instance-Number
  instance = aws_instance.web[count.index].id
  domain   = "vpc"
}
