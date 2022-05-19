# DB Instance 생성
resource "aws_db_instance" "digda-DB" {
  allocated_storage      = 10
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t2.micro"
  name                   = "petclinic"
  username               = "root"
  password               = "petclinic"
  port                   = "3306"
  identifier             = "petclinic"
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.digda-subnet-group.id
  vpc_security_group_ids = ["${aws_security_group.digda-db-sg.id}"]
  multi_az               = true
}
