# AWS의 사용 Region 설정 - Seoul로 지정
provider "aws" {
  region = "ap-northeast-2"
}


# VPC 생성 - 10.0.0.0/16 cidr 사용
resource "aws_vpc" "digda_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "digda_vpc"
  }
}
