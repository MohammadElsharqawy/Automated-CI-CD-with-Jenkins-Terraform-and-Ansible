variable "region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet1_cidr" {
  type = string
}

variable "public_subnet2_cidr" {
  type = string
}

variable "private_subnet1_cidr" {
  type = string
}

variable "private_subnet2_cidr" {
  type = string
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

# variable "cnt" {
#   type = string
# }

variable "verified_email" {
  type = string
}

variable "database_server" {
  type = object({
        db_password = string
        db_username = string
        db_name = string
        db_engine = string
        db_engine_version = string  
        db_instance_class = string
        db_allocated_storage = number
  })
}

variable "redis_cluster" {
    type = object({
        cluster_id      = string
        cluster_engine  = string
        cluster_nodetype = string
        cluster_nOfnodes = number
        cluster_port    = number
        cluster_port_engine_version = string
})
}