module "network" {
  source  = "../../modules/network"
  region  = var.region
}

module "firewall" {
  source  = "../../modules/firewall"
  network = module.network.vpc_id
}

module "nat" {
  source     = "../../modules/nat"
  region     = var.region
  network_id = module.network.vpc_id
}

module "cloudsql" {
  source     = "../../modules/cloudsql"
  region     = var.region
  network_id = module.network.vpc_id
  db_user    = "devuser" # Or reference from secret if needed
  db_pass    = null # Will be generated in module
}

module "mig" {
  source         = "../../modules/mig"
  zone           = var.zone
  private_subnet = module.network.private_subnet_id
}

module "loadbalancer" {
  source = "../../modules/loadbalancer"
}

module "service_accounts" {
  source = "../../modules/service_accounts"
}
