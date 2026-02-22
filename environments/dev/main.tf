module "network" {
  source = "../../modules/network"
  region = var.region
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

# Removed service_accounts module - the service account for Terraform 
# is already created and configured in GCP for GitHub Actions

module "cloudsql" {
  source     = "../../modules/cloudsql"
  region     = var.region
  network_id = module.network.vpc_id
  db-user-v2 = var.db-user-v2 # Or reference from secret if needed
  db-pass-v2 = var.db-pass-v2 # Will be generated in module
}

module "mig" {
  source         = "../../modules/mig"
  zone           = var.zone
  private_subnet = module.network.private_subnet_id
}

module "loadbalancer" {
  source = "../../modules/loadbalancer"
}
