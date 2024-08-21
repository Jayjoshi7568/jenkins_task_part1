
resource "aws_instance" "public" {
  ami                         = var.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = module.vpc.public_subnets[0]
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  tags                        = var.instance_tags_1
}

resource "aws_instance" "private" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = module.vpc.private_subnets[0]
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  tags                        = var.instance_tags_2
}