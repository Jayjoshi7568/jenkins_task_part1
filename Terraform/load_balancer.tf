resource "aws_lb" "app" {
  name               = "jenkins-task-02"
  internal           = false
  load_balancer_type = "application"
  subnets            = [module.vpc.public_subnets[0],module.vpc.public_subnets[1]]
  security_groups    = [aws_security_group.sg.id]
  depends_on = [ aws_security_group.sg ]
}


resource "aws_lb_listener" "http-listener" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group" "target-group" {
  name     = "jenkins-task2-target"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}

resource "aws_lb_target_group_attachment" "jenkins-server" {
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = aws_instance.public.id
  port             = 8080
  depends_on = [ aws_instance.public ]
}

resource "aws_lb_listener" "https-listener" {
  load_balancer_arn = aws_lb.app.arn
  port              = "443"
  protocol          = "HTTP"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}
