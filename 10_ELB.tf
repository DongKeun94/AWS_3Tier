### 내외부 Load Balancer 생성 ###

# 외부 Load Balancer 생성
resource "aws_lb" "digda-external-elb" {
  name               = "digda-external-elb"
  subnets            = ["${aws_subnet.digda-pub-a.id}", "${aws_subnet.digda-pub-c.id}"]
  security_groups    = ["${aws_security_group.digda-EX-ELB-sg.id}"]
  load_balancer_type = "application"

  tags = {
    Name = "digda-external-elb"
  }
}

# 외부 Load Balancer의 Target Group 생성 - 80번 Port
resource "aws_lb_target_group" "digda-tg" {
  name     = "digda-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.digda_vpc.id

  health_check {
    interval            = 30
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# 외부 LB의 TG에 WEB-A Instance를 등록 
resource "aws_lb_target_group_attachment" "digda-tg-attach" {
  target_group_arn = aws_lb_target_group.digda-tg.arn
  target_id        = aws_instance.digda-web-a.id
  port             = 80
}

# 외부 LB의 TG에 WEB-C Instance를 등록
resource "aws_lb_target_group_attachment" "digda-tg-attach2" {
  target_group_arn = aws_lb_target_group.digda-tg.arn
  target_id        = aws_instance.digda-web-c.id
  port             = 80

}

# 외부 LB의 Listener 등록 - 80번 Port
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.digda-external-elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.digda-tg.arn
    type             = "forward"
  }
}


# 내부 Load Balancer 생성
resource "aws_lb" "digda-internal-elb" {
  name               = "digda-internal-elb"
  subnets            = ["${aws_subnet.digda-was-a.id}", "${aws_subnet.digda-was-c.id}"]
  security_groups    = ["${aws_security_group.digda-IN-ELB-sg.id}"]
  load_balancer_type = "application"
  internal           = true

  tags = {
    Name = "digda-internal-elb"
  }
}

# 내부 Load Balancer의 Target Group 생성 - 8080번 Port
resource "aws_lb_target_group" "digda-tg-1" {
  name     = "digda-tg-1"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.digda_vpc.id

  health_check {
    interval            = 30
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# 내부 LB의 TG에 WAS-A Instance를 등록
resource "aws_lb_target_group_attachment" "digda-tg-attach3" {
  target_group_arn = aws_lb_target_group.digda-tg-1.arn
  target_id        = aws_instance.digda-was-a.id
  port             = 8080
}

# 내부 LB의 TG에 WAS-C Instance를 등록
resource "aws_lb_target_group_attachment" "digda-tg-attach4" {
  target_group_arn = aws_lb_target_group.digda-tg-1.arn
  target_id        = aws_instance.digda-was-c.id
  port             = 8080
}

# 내부 LB의 Listener 등록 - 8080번 Port
resource "aws_alb_listener" "was" {
  load_balancer_arn = aws_lb.digda-internal-elb.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.digda-tg-1.arn
    type             = "forward"
  }
}
