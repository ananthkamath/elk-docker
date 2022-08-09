# ELK-Docker

A Containerized setup for ELK Stack. This repo includes a dockerized setup for ELK stack and also include a nginx server which creates logs that can be used as seed logs or data for your ELK stack setup.

Feel free to modify the logstash or filebeat to include different set of logs from your hosts. You can also setup filebeat on remote hosts from where you are planning to send logs to Elasticsearch.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

What things you need to install the software and how to install them:

- [Docker](https://docs.docker.com/)
- [Packer](https://www.packer.io/)
- [Terraform](https://www.terraform.io/)

### Setup

#### 1. Clone the repository

```
git clone git@github.com:ananthkamath/elk-docker.git && cd elk-docker
```

#### 2. Update Config

If you want to make changes to logstash or filebeat config, update the required configs in `./logstash` or `./filebeat`.

#### 3. Kick off the setup

```
docker-compose up -d
```

#### 4. Kibana Dashboard

Kibana dashboard will be accessible at [localhost:5601](http://localhost:5601)

#### 5. Index Management

To view the index you setup via logstash and filebeat in elasticsearch in [Kibana Index Management](http://localhost:5601/app/management/kibana/indexPatterns/create)

If you are not seeing the index yet, visit [Nginx Page](http://localhost/) few times or create logs via the application on you remote host machine.

#### 6. Logs

Once you have created the index visit [discover page](http://localhost:5601/app/discover)

#### 7. Packer

Use packer to build AWS AMI to be used by terraform to deploy on spot instances

```
cd packer
packer init .
packer fmt .
packer build elk-docker-ami.pkr.hcl
```

#### 8. Terraform

Use terraform script to spin up ELK Docker on AWS spot instance in default VPC. Feel free to update the terraform config accordingly

```
cd terraform
terraform init
terraform fmt
terraform validate
terraform plan -out=tfplan
terraform apply
```