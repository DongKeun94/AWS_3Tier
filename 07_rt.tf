### Route Table 생성 및 규칙 규정 ###

# Public Route Table 생성 - IGW로 통하게 규정
resource "aws_route_table" "digda-public-route" {
  vpc_id = aws_vpc.digda_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.digda_IGW.id
  }

  tags = {
    Name = "digda-public-route"
  }
}


# Private Route Table 생성 - NAT로 통하게 규정
resource "aws_route_table" "digda-private-route" {
  vpc_id = aws_vpc.digda_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.digda-NAT.id
  }

  tags = {
    Name = "digda-private-route"
  }
}


# Public Route Table에 Public Subnet 등록
resource "aws_route_table_association" "public-route" {
  subnet_id      = aws_subnet.digda-pub-a.id
  route_table_id = aws_route_table.digda-public-route.id
}
resource "aws_route_table_association" "public-route1" {
  subnet_id      = aws_subnet.digda-pub-c.id
  route_table_id = aws_route_table.digda-public-route.id
}


# Private Route Table에 Private Subnet 등록
resource "aws_route_table_association" "private-route" {
  subnet_id      = aws_subnet.digda-web-a.id
  route_table_id = aws_route_table.digda-private-route.id
}
resource "aws_route_table_association" "private-route1" {
  subnet_id      = aws_subnet.digda-web-c.id
  route_table_id = aws_route_table.digda-private-route.id
}
resource "aws_route_table_association" "private-route2" {
  subnet_id      = aws_subnet.digda-was-a.id
  route_table_id = aws_route_table.digda-private-route.id
}
resource "aws_route_table_association" "private-route3" {
  subnet_id      = aws_subnet.digda-was-c.id
  route_table_id = aws_route_table.digda-private-route.id
}
resource "aws_route_table_association" "private-route4" {
  subnet_id      = aws_subnet.digda-db-a.id
  route_table_id = aws_route_table.digda-private-route.id
}
resource "aws_route_table_association" "private-route5" {
  subnet_id      = aws_subnet.digda-db-c.id
  route_table_id = aws_route_table.digda-private-route.id
}
