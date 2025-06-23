
module "zimbra" {
  source        = "./modules/zimbra_instance"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  region        = var.aws_region
}

output "zimbra_public_ip" {
  value = module.zimbra.public_ip
}

output "zimbra_dns" {
  value = module.zimbra.public_dns
}
