region               = "eu-central-1"
vpc_cidr             = "10.0.0.0/16"
public_subnet1_cidr  = "10.0.0.0/24"
public_subnet2_cidr  = "10.0.1.0/24"
private_subnet1_cidr = "10.0.2.0/24"
private_subnet2_cidr = "10.0.3.0/24"
ami                  = "ami-0e86e20dae9224db8"
instance_type        = "t2.micro"
verified_email       = "mohammadelsharqawyegy@gmail.com"
 database_server = {
  db_password          = "12345"
  db_username          = "mydb"
  db_name              = "mydb"
  db_engine            = "mysql"
  db_engine_version    = "5.7"
  db_instance_class    = "db.t3.micro"
  db_allocated_storage = 10
}
redis_cluster = {
    cluster_id      = "elsharq-redis-cluster"
    cluster_engine  =  "redis"
    cluster_nodetype = "cache.t3.micro"
    cluster_nOfnodes = 1
    cluster_port    = 6379
    cluster_engine_version  = "7.1"
}
