# NAT Gateway에 부착할 고정IP 생성
resource "aws_eip" "digda-NAT-eip" {
  vpc = true

  tags = {
    Name = "digda-NAT-eip"
  }
}
