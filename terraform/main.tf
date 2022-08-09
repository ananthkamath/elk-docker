data "aws_vpc" "selected" {
  # In case you are not using default VPC comment default = true and provide VPC ID as value to variable vpc_id
  default = true
  # id = var.vpc_id
}

data "aws_subnet_ids" "selected" {
  vpc_id = data.aws_vpc.selected.id
}

data "aws_subnet" "selected" {
  for_each = data.aws_subnet_ids.selected.ids
  id       = each.value
}

data "aws_ami" "elk-docker" {
  filter {
    name   = "name"
    values = [var.ami_name]
  }

  most_recent = true
  owners      = ["self"]
}

data "template_file" "userdata" {
  template = file("startup.sh")
}

# Request a spot instance
resource "aws_spot_instance_request" "elk_docker" {
  ami           = data.aws_ami.elk-docker.id
  instance_type = "t3.xlarge"
  key_name      = var.key_name
  wait_for_fulfillment = "true"

  associate_public_ip_address = true
  subnet_id              = element(data.aws_subnet_ids.selected.ids.*, 0)
  vpc_security_group_ids = [aws_security_group.elk_docker_sg.id]


  user_data = data.template_file.userdata.rendered

  tags = {
    Name = "elk-docker-spot-instance"
  }
}
