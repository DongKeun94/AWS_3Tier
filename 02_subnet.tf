### 앞서 생성한 VPC를 Subnet 단위로 나누는 작업 ###

# Public Subnet 생성 - a가용영역
resource "aws_subnet" "digda-pub-a" {
  vpc_id                  = aws_vpc.digda_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = false
  tags = {
    Name = "digda-pub-a"
  }
}


# Public Subnet 생성 - c가용영역
resource "aws_subnet" "digda-pub-c" {
  vpc_id                  = aws_vpc.digda_vpc.id
  cidr_block              = "10.0.11.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = false
  tags = {
    Name = "digda-pub-c"
  }
}


# WEB Private Subnet 생성 - a가용영역
resource "aws_subnet" "digda-web-a" {
  vpc_id                  = aws_vpc.digda_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = false
  tags = {
    Name = "digda-web-a"
  }
}


# WEB Private Subnet 생성 - c가용영역
resource "aws_subnet" "digda-web-c" {
  vpc_id                  = aws_vpc.digda_vpc.id
  cidr_block              = "10.0.12.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = false
  tags = {
    Name = "digda-web-c"
  }
}


# WAS Private Subnet 생성 - a가용영역
resource "aws_subnet" "digda-was-a" {
  vpc_id                  = aws_vpc.digda_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = false
  tags = {
    Name = "digda-was-a"
  }
}


# WAS Private Subnet 생성 - c가용영역
resource "aws_subnet" "digda-was-c" {
  vpc_id                  = aws_vpc.digda_vpc.id
  cidr_block              = "10.0.13.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = false
  tags = {
    Name = "digda-was-c"
  }
}


# DB Private Subnet 생성 - a가용영역
resource "aws_subnet" "digda-db-a" {
  vpc_id                  = aws_vpc.digda_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = false
  tags = {
    Name = "digda-db-a"
  }
}


# DB Private Subnet 생성 - c가용영역
resource "aws_subnet" "digda-db-c" {
  vpc_id                  = aws_vpc.digda_vpc.id
  cidr_block              = "10.0.14.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = false
  tags = {
    Name = "digda-db-c"
  }
}
