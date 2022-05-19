# NAT Gateway 생성
resource "aws_nat_gateway" "digda-NAT" {
  allocation_id = aws_eip.digda-NAT-eip.id
  subnet_id     = aws_subnet.digda-pub-a.id

  tags = {
    Name = "digda-NAT"
  }
}
