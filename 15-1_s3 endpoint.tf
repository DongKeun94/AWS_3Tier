# Private Instance에서 S3로의 접속을 위한 VPC Endpoint 설정
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.digda_vpc.id
  service_name = "com.amazonaws.ap-northeast-2.s3"
}


# Private Route Table에 VPC Endpoint로 경로 설정
resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_routetable" {
  route_table_id  = aws_route_table.digda-private-route.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}
