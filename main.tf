module "frontend"{
source = "./module/app"
vault_token = var.vault_token
env  = var.env
instance_type = var.instance_type
component = "frontend"
zone_id =var.zone_id
}