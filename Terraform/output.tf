output "public-ip" {
  value = aws_instance.public.public_ip
}

output "private-ip" {
  value = aws_instance.private.private_ip
}