output "web_lb" {
  value = "http://${aws_lb.digda-internal-elb.dns_name}"
  
}