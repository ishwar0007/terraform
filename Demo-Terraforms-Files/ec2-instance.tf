# Aws Credentials
provider "aws" {
  region = "ap-south-1"
  access_key = "access-key-value"
  secret_key = "secret-key-value"
}

# Creating EC2 Instance
resource "aws_instance" "web" {
  ami           = "ami-05e00961530ae1b55"           //Ubuntu 22.04
  instance_type = "t2.micro"
  key_name   = "Hunter"
  vpc_security_group_ids = ["sg-089db7c8226396a11"]
  user_data = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install zip unzip net-tools nginx -y
sudo echo "Hunter" >> /var/www/index.nginx-debian.html
EOF
  root_block_device {
    volume_size = 20 # Adjust volume size in GB
    delete_on_termination = "true"
  }
  tags = {
    Name = "Terraform-First-Instance"
  }
  # File provisiner will copy file from local to newly create server.
  provisioner "file" {
    source = "test.sh"
    destination = "/home/ubuntu/test.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("${path.module}/my-key")
      host = "${self.public_ip}"          // It will extract the public ip of the instance
    }
  }

  # Local provisiner to run command in the local
  provisioner "local-exec" {
    command = "echo 'START'"
  }

  # Local provisiner to run command in the local only when terraform destroy runs
  provisioner "local-exec" {
    when = destroy
    command = "echo 'DELETE'"
  }

  # Remote provisiner to run command on the remote resource, remote-exec always reqvim 
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("${path.module}/my-key")
      host = "${self.public_ip}"          // It will extract the public ip of the instance
    }
    inline = [
      "df -h",
      "curl ifconfig.io >> /home/ubuntu/output.txt"
    ]
  }

  # Remote provisiner to run command  on the remote resource. 
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("${path.module}/my-key")
      host = "${self.public_ip}"          // It will extract the public ip of the instance
    }
    script = "./new.sh"       // It will copy script from local to remote and execute the script
  }
}

# Allocating new elastic Ip and assign it to the newly created instance
resource "aws_eip" "lb" {
  instance = aws_instance.web.id
  domain   = "vpc"
}
