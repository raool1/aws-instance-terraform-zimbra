variable "region" {
  description = "The AWS region to deploy resources in"
  default     = "ap-southeast-2"
}

variable "ami_id" {
  description = "AMI ID to use for the EC2 instance"
  default     = "ami-0014b58dde05db178"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.medium"
}

variable "key_name" {
  description = "AWS EC2 Key Pair"
  default     = "terraform-zimbra"
}
