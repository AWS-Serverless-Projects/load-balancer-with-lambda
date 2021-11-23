variable "ALB_DELETION_PROTECTION" { default=true }

resource "aws_lb" "load-balancer" {
  name               = "my-demo-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow-all-traffic.id]
  subnets            = [aws_subnet.subnetfirst.id, aws_subnet.subnetsecond.id]
  enable_deletion_protection = var.ALB_DELETION_PROTECTION

  tags = {
    Environment = "demo"
  }
}

resource "aws_lb_target_group" "lambda-target-group" {
  name        = "demo-lambda-target-group"
  target_type = "lambda"
}

resource "aws_lb_target_group_attachment" "alb-target-group-attachment" {
  target_group_arn = aws_lb_target_group.lambda-target-group.arn
  target_id        = aws_lambda_function.lambda.arn
  depends_on       = [aws_lambda_permission.with_lb]
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.load-balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lambda-target-group.arn
  }
}

resource "aws_security_group" "allow-all-traffic" {
  name        = "allow_all_traffic"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.mydemovpc.id

  ingress {
    description = "All traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
