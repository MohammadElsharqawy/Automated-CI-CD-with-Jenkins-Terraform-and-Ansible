# Creating subnet groups
resource "aws_elasticache_subnet_group" "elasticahe_subnet_group" {
  name = "elasticahe-subnet-group"
  subnet_ids = [
    module.network.private_subnet1_id,
    module.network.private_subnet2_id
  ]

  tags = {
    Name = "Elasticahe Private Subnet Group"
  }
}

# Create the ElastiCache cluster
resource "aws_elasticache_cluster" "redis_cluster" {
  cluster_id           = var.redis_cluster.cluster_id
  engine               = var.redis_cluster.cluster_engine_version
  node_type            = var.redis_cluster.cluster_nodetype
  num_cache_nodes      = var.redis_cluster.cluster_nOfnodes
  parameter_group_name = "default.redis7"
  engine_version       = var.redis_cluster.cluster_engine
  port                 = var.redis_cluster.cluster_port
  subnet_group_name    = aws_elasticache_subnet_group.elasticahe_subnet_group.name

  security_group_ids = [aws_security_group.elasticache_security_group.id]
}


