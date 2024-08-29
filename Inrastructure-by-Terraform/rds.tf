# Creating subnet groups
resource "aws_db_subnet_group" "mydb_subnet_group" {
  name = "mydb-subnet-group"
  subnet_ids = [
    module.network.private_subnet1_id,
    module.network.private_subnet2_id
  ]

  tags = {
    Name = "MyDB Private Subnet Group"
  }
}

# Creating rds
resource "aws_db_instance" "default" {
  allocated_storage                   = var.database_server.allocated_storage
  db_name                             = var.database_server.db_name
  engine                              = var.database_server.db_engine
  engine_version                      = var.database_server.db_engine_version
  instance_class                      = var.database_server.db_instance_class
  username                            = var.database_server.db_username
  password                            = var.database_server.db_password

  db_subnet_group_name   = aws_db_subnet_group.mydb_subnet_group.name
  vpc_security_group_ids = [aws_security_group.sg2_allow_3000_and_shh_from_vpc.id]
  skip_final_snapshot    = true
}