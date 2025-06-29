module "frontend"{
source = "./module/app"
vault_token = var.vault_token
env  = var.env
instance_type = var.instance_type
component = "frontend"
zone_id =var.zone_id
app_port = 80
}

module "rds"{
source = "./module/rds"
allocated_storage = 20
engine = "mysql"
engine_version = "MySQL8.0.36"
instance_class = "db.t3.micro"
storage_type = "gp3"
publicly_accessible = "no"
family = "mysql8.0"
multi_az = false
}

