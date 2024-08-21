# VPC Variables
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "jenkins-vpc"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "The list of availability zones for the VPC"
  type        = list(string)
  default     = ["us-east-1a","us-east-1b"]
}


variable "vpc_tags" {
  description = "Tags to apply to the VPC"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Security Group Variables
variable "public_sg_name" {
  description = "The name of the public security group"
  type        = string
  default     = "public-sg-jenkins"
}

variable "allowed_egress_cidr_blocks" {
  description = "The CIDR blocks allowed for egress traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ssh_cidr_blocks" {
  description = "The CIDR blocks allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# EC2 Instance Variables
variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-04a81a99f5ec58529"
}

variable "instance_type" {
  description = "The type of the EC2 instance"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "The key name to use for the EC2 instance"
  type        = string
  default     = "my-key-pair"
}

variable "instance_tags_1" {
  description = "Tags to apply to the EC2 instance"
  type        = map(string)
  default = {
    Name = "jenkins_public"
  }
}

variable "instance_tags_2" {
  description = "Tags to apply to the EC2 instance"
  type        = map(string)
  default = {
    Name = "jenkins_private"
  }
}
