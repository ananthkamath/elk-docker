output instance_ip {
  value = aws_spot_instance_request.elk_docker.public_ip
}

output kibana_endpoint {
  value = "http://${aws_spot_instance_request.elk_docker.public_ip}:5601"
}

output nginx_endpoint {
  value = "http://${aws_spot_instance_request.elk_docker.public_ip}"
}
