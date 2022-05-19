# Internet Gateway 생성
resource "aws_internet_gateway" "digda_IGW" {
  vpc_id = aws_vpc.digda_vpc.id

  tags = {
    Name = "digda_IGW"
  }
}
