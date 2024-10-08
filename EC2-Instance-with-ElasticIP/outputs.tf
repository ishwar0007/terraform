output "Elastic_IP" {
  description = "Elastic IP of the newly created server"
  value = [
    for instance in aws_instance.web : {
      id       = instance.id
      name      = lookup(instance.tags, "Name", "No Name")
      public_ip = instance.public_ip
    }
  ]
}
