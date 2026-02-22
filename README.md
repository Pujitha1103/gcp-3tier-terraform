# GCP 3-Tier Terraform Architecture

## Overview
This repository provisions a 3-tier architecture on Google Cloud Platform using Terraform. It includes:
- VPC network with public/private subnets
- Firewall rules
- Cloud NAT
- Managed Instance Group (MIG) for app tier
- HTTP Load Balancer
- Cloud SQL (MySQL)
- Service Accounts

## Structure
- `modules/`: Reusable Terraform modules for each component
- `environments/dev` and `environments/prod`: Environment-specific configurations
- `backend/`: Remote state backend config
- Root: Provider, versions, and shared variables

## Usage
1. Install [Terraform](https://www.terraform.io/downloads.html)
2. Configure your GCP credentials (e.g., `gcloud auth application-default login`)
3. Edit `terraform.tfvars` in your environment folder with your project and secrets
4. Initialize and apply:
   ```sh
   cd environments/dev # or prod
   terraform init
   terraform apply
   ```

## Module Wiring Example
```
module "network" { ... }
module "firewall" { ... }
module "nat" { ... }
module "cloudsql" { ... }
module "mig" { ... }
module "loadbalancer" { ... }
module "service_accounts" { ... }
```

## Notes
- State is stored in a GCS bucket (see `backend/backend.tf`)
- All secrets should be managed securely (never commit real passwords)
- Extend modules as needed for your use case

## Authors
- Your Name

## License
MIT
