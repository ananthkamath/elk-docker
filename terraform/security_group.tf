### Security Group
resource "aws_security_group" "elk_docker_sg" {
  name = "elk-docker-sg"

  vpc_id = data.aws_vpc.selected.id

  tags = {
    "Name" = "elk-docker-security-group"
  }
}

resource "aws_security_group_rule" "ingress_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.elk_docker_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Expose ssh connection"
}

resource "aws_security_group_rule" "ingress_kibana_dashboard" {
  type              = "ingress"
  from_port         = 5601
  to_port           = 5601
  protocol          = "tcp"
  security_group_id = aws_security_group.elk_docker_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Expose Kibana Dashboard"
}

resource "aws_security_group_rule" "ingress_nginx_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.elk_docker_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Expose HTTP Port 80"
}

resource "aws_security_group_rule" "outbound_default" {
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "all"
  security_group_id = aws_security_group.elk_docker_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "default outbound rule"
}
