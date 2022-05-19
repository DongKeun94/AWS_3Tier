### Instance들의 Security Group 생성 및 규칙 규정 ###

# Bastion의 Security Group을 생성
resource "aws_security_group" "digda-bastion-sg" {
  vpc_id = aws_vpc.digda_vpc.id
  name   = "digda-bastion-sg"
  tags = {
    Name = "digda-bastion-sg"
  }
}


# 외부 Load Balancer의 Security Group을 생성
resource "aws_security_group" "digda-EX-ELB-sg" {
  vpc_id = aws_vpc.digda_vpc.id
  name   = "digda-EX-ELB-sg"
  tags = {
    Name = "digda-EX-ELB-sg"
  }
}


# WEB Server의 Security Group을 생성
resource "aws_security_group" "digda-web-sg" {
  vpc_id = aws_vpc.digda_vpc.id
  name   = "digda-web-sg"
  tags = {
    Name = "digda-web-sg"
  }
}


# 내부 Load Balancer의 Security Group을 생성
resource "aws_security_group" "digda-IN-ELB-sg" {
  vpc_id = aws_vpc.digda_vpc.id
  name   = "digda-IN-ELB-sg"
  tags = {
    Name = "digda-IN-ELB-sg"
  }
}


# WAS Server의 Security Group을 생성
resource "aws_security_group" "digda-was-sg" {
  vpc_id = aws_vpc.digda_vpc.id
  name   = "digda-was-sg"
  tags = {
    Name = "digda-was-sg"
  }
}


# DB Server의 Security Group을 생성
resource "aws_security_group" "digda-db-sg" {
  vpc_id = aws_vpc.digda_vpc.id
  name   = "digda-db-sg"
  tags = {
    Name = "digda-db-sg"
  }
}


# Bastion SG의 규칙 규정 - 22번 Port Open
resource "aws_security_group_rule" "digda-bastion-sg-role" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.digda-bastion-sg.id
}
resource "aws_security_group_rule" "digda-bastion-sg-role1" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.digda-bastion-sg.id
}


# 외부 Load Balancer SG의 규칙 규정 - 80번 Port Open
resource "aws_security_group_rule" "digda-EX-ELB-sg-role" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.digda-EX-ELB-sg.id
}
resource "aws_security_group_rule" "digda-EX-ELB-sg-role1" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.digda-EX-ELB-sg.id
}


# WEB Server SG의 규칙 규정 - 22번, 80번 Port Open
resource "aws_security_group_rule" "digda-web-role" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.digda-web-sg.id
  source_security_group_id = aws_security_group.digda-EX-ELB-sg.id
}
resource "aws_security_group_rule" "digda-web-role1" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.digda-web-sg.id
}
resource "aws_security_group_rule" "digda-web-sg-role2" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.digda-web-sg.id
}


# 내부 Load Balancer SG의 규칙 규정 - 8080번 Port Open
resource "aws_security_group_rule" "digda-IN-ELB-sg-role" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.digda-IN-ELB-sg.id
  source_security_group_id = aws_security_group.digda-web-sg.id
}
resource "aws_security_group_rule" "digda-IN-ELB-sg-role1" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.digda-IN-ELB-sg.id
}


# WAS Server SG의 규칙 규정 - 22번, 8080번 Port Open
resource "aws_security_group_rule" "digda-was-sg-role" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.digda-was-sg.id
  source_security_group_id = aws_security_group.digda-IN-ELB-sg.id
}
resource "aws_security_group_rule" "digda-was-sg-role1" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.digda-was-sg.id
}
resource "aws_security_group_rule" "digda-was-sg-role2" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.digda-was-sg.id
}


# DB Server SG의 규칙 규정 - 3306번 Port Open
resource "aws_security_group_rule" "digda-db-sg-role" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.digda-db-sg.id
}
resource "aws_security_group_rule" "digda-db-sg-role1" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.digda-db-sg.id
}
