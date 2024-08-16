terraform {
  backend "s3" {
    bucket = "my-terraform-backend-xyz"
    region = "ap-south-1"
    key = "jenkins_project_02/terraform.tfstate"
  }
}