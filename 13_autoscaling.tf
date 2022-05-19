### Auto Scaling을 위한 요소들 구성 ###

# Auto Scaling을 위한 WEB Instance의 AMI 생성
resource "aws_ami_from_instance" "digda_ami" {

  name               = "digda-ami"
  source_instance_id = aws_instance.digda-web-a.id
  depends_on = [
    aws_instance.digda-web-a
  ]
}


# 앞서 생성한 AMI를 토대로 Launch Configuration 구성
resource "aws_launch_configuration" "digda_lacf" {

  name                 = "digda-web"
  image_id             = aws_ami_from_instance.digda_ami.id
  instance_type        = "t3.medium"
  iam_instance_profile = "admin_role"
  security_groups      = [aws_security_group.digda-web-sg.id]
  key_name             = "digda_key"

  lifecycle {
    create_before_destroy = true
  }
}


# Auto Scaling Group 생성
resource "aws_autoscaling_group" "digda_autogroup" {
  name                      = "digda-autogroup"
  min_size                  = 2
  max_size                  = 6
  health_check_grace_period = 100
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.digda_lacf.name
  vpc_zone_identifier       = [aws_subnet.digda-web-a.id, aws_subnet.digda-web-c.id]

}


# 앞서 생성한 Auto Scaling Group을 LB의 Target Group으로 등록
resource "aws_autoscaling_attachment" "digda_autoattach" {

  autoscaling_group_name = aws_autoscaling_group.digda_autogroup.id
  alb_target_group_arn   = aws_lb_target_group.digda-tg.arn

}
