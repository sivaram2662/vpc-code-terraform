resource "aws_security_group" "alb-sg" {
  name        = "allow_tls end user "
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.stage-vpc.id

  ingress {
    description = "end user"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "pk-alb-sg"
  }
}


resource "aws_lb_target_group" "alb-tg" {
  name     = "jenkins-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.stage-vpc.id
}



resource "aws_lb_target_group_attachment" "testing" {
  target_group_arn = aws_lb_target_group.alb-tg.id
  target_id        = aws_instance.apache.id
  port             = 8080
}