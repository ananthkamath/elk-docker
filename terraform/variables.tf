variable "aws_region" {
  default = "ap-south-1"
}

variable "ami_name" {
  default = "elk-docker"
}

variable "instance_type" {
  default = "t3.xlarge"
}

variable "key_name" {
  default = "keyName"
}

variable "vpc_id" {
  default = "default"
}

variable "packer_file_name" {
  default = "elk-docker-ami.pkr.hcl"
}
