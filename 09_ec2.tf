### Bastion, WEB Server, WAS Server Instance 생성 ###

# Bastion Instance 생성
resource "aws_instance" "digda-bastion" {
  ami                         = "ami-0f8b8babb98cc66d0"
  instance_type               = "t3.medium"
  iam_instance_profile        = "admin_role"
  subnet_id                   = aws_subnet.digda-pub-a.id
  vpc_security_group_ids      = ["${aws_security_group.digda-bastion-sg.id}"]
  key_name                    = aws_key_pair.digda_key.key_name
  user_data                   = file("control.sh")
  associate_public_ip_address = true

  tags = {
    Name = "digda-bastion"
  }
}


# WEB Server Instance 생성 - a가용영역
resource "aws_instance" "digda-web-a" {
  ami                         = "ami-0f8b8babb98cc66d0"
  instance_type               = "t3.medium"
  iam_instance_profile        = "admin_role"
  private_ip                  = "10.0.2.12"
  subnet_id                   = aws_subnet.digda-web-a.id
  vpc_security_group_ids      = ["${aws_security_group.digda-web-sg.id}"]
  key_name                    = aws_key_pair.digda_key.key_name
  user_data                   = data.template_file.web_data.rendered
  associate_public_ip_address = false

  tags = {
    Name = "digda-web-a"
  }
}


# WEB Server Instance 생성 - c가용영역
resource "aws_instance" "digda-web-c" {
  ami                         = "ami-0f8b8babb98cc66d0"
  instance_type               = "t3.medium"
  iam_instance_profile        = "admin_role"
  private_ip                  = "10.0.12.12"
  subnet_id                   = aws_subnet.digda-web-c.id
  vpc_security_group_ids      = ["${aws_security_group.digda-web-sg.id}"]
  key_name                    = aws_key_pair.digda_key.key_name
  user_data                   = data.template_file.web_data.rendered
  associate_public_ip_address = false

  tags = {
    Name = "digda-web-c"
  }
}


# WAS Server Instance 생성 - a가용영역
resource "aws_instance" "digda-was-a" {
  ami                         = "ami-0f8b8babb98cc66d0"
  instance_type               = "t3.medium"
  iam_instance_profile        = "admin_role"
  private_ip                  = "10.0.3.12"
  subnet_id                   = aws_subnet.digda-was-a.id
  vpc_security_group_ids      = ["${aws_security_group.digda-was-sg.id}"]
  key_name                    = aws_key_pair.digda_key.key_name
  user_data                   = file("install_was.sh")
  associate_public_ip_address = false

  tags = {
    Name = "digda-was-a"
  }
}


# WAS Server Instance 생성 - c가용영역
resource "aws_instance" "digda-was-c" {
  ami                         = "ami-0f8b8babb98cc66d0"
  instance_type               = "t3.medium"
  iam_instance_profile        = "admin_role"
  private_ip                  = "10.0.13.12"
  subnet_id                   = aws_subnet.digda-was-c.id
  vpc_security_group_ids      = ["${aws_security_group.digda-was-sg.id}"]
  key_name                    = aws_key_pair.digda_key.key_name
  user_data                   = file("install_was.sh")
  associate_public_ip_address = false

  tags = {
    Name = "digda-was-c"
  }
}
