# CC Test

## AWS and Letsencrypt provisioning with Terraform

## missing ingredients

  - ssh keys (under `files/cc_rsa` and `files/cc_rsa.pub`)
  - aws credentials (under `~/.aws/credentials`)
  - terraform-provider-acme (download and place under terraform.d)
  - modules (download and place them under `modules/`)


## AWS resources created by terraform

  - vpc
  - public subnet
  - igw
  - route table
  - security groups
  - user_data to do initial provisioning (install puppet, git)
  - key pair
  - ELB
  - ec2 with elastic ip
  - hook up the elastic ip with the domain name in route53
  - load the letsencrypt certificate into the ELB
  - KMS master key


## TODO

  - S3 bucket
  - IAM role to give access to the S3 bucket to the EC2
  - IAM role to allow KMS decryption from the EC2

