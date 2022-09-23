resource "aws_instance" "apache" {
  ami           = "ami-06489866022e12a14"
  instance_type = "t2.micro"
  key_name = "siva"
  vpc_security_group_ids = [aws_security_group.alb-sg.id]
  user_data = <<EOF
             #!/bin/bash
             yum update -y
             yum install httpd -y 
             systemctl enable httpd
             systemctl start httpd
             echo "this is valiball" >/var/www/html/valiball/index.html/
       EOF

  tags = {
    Name = "sivaram"
  }
}