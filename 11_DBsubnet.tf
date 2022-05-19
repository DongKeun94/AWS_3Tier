# DB Subnet Group 생성
resource "aws_db_subnet_group" "digda-subnet-group" {
  name       = "digda-subnet-group"
  subnet_ids = [aws_subnet.digda-db-a.id, aws_subnet.digda-db-c.id]

  tags = {
    Name = "digda-subnet-group"
  }
}
