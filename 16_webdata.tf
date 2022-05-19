# WEB-WAS 연동시 필요한 LB의 DNS Name 변수 처리
data "template_file" "web_data" {
  template = file("install_seoul.sh")
  vars = {
    web_lb_name = aws_lb.digda-internal-elb.dns_name
  }
}
