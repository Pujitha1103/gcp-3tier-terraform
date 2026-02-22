# 🚀 GCP Production 3-Tier Web Application (Terraform)

## 📌 Project Overview

This project provisions a **production-grade 3-tier web application
architecture on Google Cloud Platform (GCP)** using **modular
Terraform**.

It demonstrates:

-   Infrastructure as Code (IaC)
-   Secure Network Architecture
-   High Availability Design
-   Auto Scaling
-   Remote State Management
-   CI/CD Automation

------------------------------------------------------------------------

# 🏗 High-Level Architecture

                            🌍 Internet
                                 |
                    ┌────────────────────────┐
                    │  Global HTTP(S) LB     │
                    └────────────────────────┘
                                 |
                    --------------------------------
                    |                              |
            ┌────────────────┐            ┌────────────────┐
            │ App Instance 1 │            │ App Instance 2 │
            │   (Zone A)     │            │   (Zone B)     │
            └────────────────┘            └────────────────┘
                    |                              |
                    ------------- VPC --------------
                                 |
                        ┌────────────────┐
                        │   Cloud SQL    │
                        │  (Private IP)  │
                        └────────────────┘

                     Private Subnet (App + DB)
                                 |
                            Cloud NAT
                         (Outbound Only)

------------------------------------------------------------------------

# 🧠 Architecture Flow

## 🔁 Request Flow

    User
      ↓
    Internet
      ↓
    Global HTTP Load Balancer
      ↓
    Managed Instance Group (App Layer)
      ↓
    Cloud SQL (Database Layer)
      ↓
    Response to User

------------------------------------------------------------------------

# 🧱 Architecture Components

## 1️⃣ VPC (Custom Mode)

-   Custom VPC created
-   Public subnet (Load Balancer)
-   Private subnet (App + DB)
-   Private Google Access enabled

### Why Custom Mode?

-   Full control over IP ranges
-   Clear network segmentation
-   Production best practice

------------------------------------------------------------------------

## 2️⃣ Global HTTP(S) Load Balancer

-   Public entry point
-   Performs health checks
-   Routes traffic only to healthy instances
-   Supports HTTPS (extendable)

------------------------------------------------------------------------

## 3️⃣ Managed Instance Group (Application Tier)

-   Stateless application servers
-   Deployed across multiple zones
-   Auto-scaling enabled
-   Minimum 2 instances
-   Maximum 4 instances
-   CPU threshold: 60%

### Scaling Logic

    CPU > 60%  → Scale Out
    CPU < 30%  → Scale In

------------------------------------------------------------------------

## 4️⃣ Cloud NAT

-   Enables outbound internet for private instances
-   Prevents inbound exposure
-   Ensures secure updates and patching

------------------------------------------------------------------------

## 5️⃣ Cloud SQL (Database Tier)

-   Private IP only
-   No public exposure
-   Accessible only inside VPC
-   Automated backups supported
-   HA configuration supported

### Database Access Flow

    App Instance (Private IP)
            ↓
    Cloud SQL (Private IP)
            ↓
    Query Response

------------------------------------------------------------------------

## 6️⃣ Firewall Rules

-   Allow HTTP (80) from 0.0.0.0/0 → Load Balancer
-   Allow DB (3306) only from App layer
-   Deny all other unnecessary traffic

Security Principle: **Least Privilege Access**

------------------------------------------------------------------------

# 🗂 Terraform Project Structure

    gcp-3tier-terraform/
    │
    ├── backend/
    │   └── backend.tf
    │
    ├── environments/
    │   └── dev/
    │
    ├── modules/
    │   ├── network/
    │   ├── nat/
    │   ├── firewall/
    │   ├── mig/
    │   ├── loadbalancer/
    │   ├── cloudsql/
    │
    ├── providers.tf
    ├── versions.tf
    └── README.md

------------------------------------------------------------------------

# 🔐 Remote State Configuration

Terraform state is stored in:

-   Google Cloud Storage (GCS)
-   Versioning enabled
-   IAM-restricted access

Benefits:

-   Team collaboration
-   State protection
-   Recovery from accidental deletion

------------------------------------------------------------------------

# 🔄 CI/CD Pipeline Flow (GitHub Actions)

    Developer Push
          ↓
    GitHub Actions Triggered
          ↓
    Terraform Init
          ↓
    Terraform Validate
          ↓
    Terraform Plan
          ↓
    Terraform Apply (Main Branch Only)
          ↓
    Infrastructure Provisioned

Security:

-   GCP Service Account authentication
-   Secrets stored in GitHub Secrets
-   No credentials stored in repository

------------------------------------------------------------------------

# 📊 High Availability Design

-   Multi-zone Managed Instance Group
-   Global Load Balancer
-   Optional Cloud SQL HA
-   Health checks enabled

------------------------------------------------------------------------

# ⚡ Scalability Design

-   Horizontal scaling via MIG
-   CPU-based autoscaling
-   Stateless architecture

------------------------------------------------------------------------

# 🛡 Security Architecture Summary

  Layer      Security Control
  ---------- ----------------------
  Network    Private Subnets
  Compute    No Public IPs
  Database   Private IP Only
  State      GCS with IAM
  Secrets    GitHub Secrets
  Ingress    Firewall Restricted
  Egress     Cloud NAT Controlled

------------------------------------------------------------------------

# 🚀 Deployment Steps

## Initialize Terraform

    terraform init

## Validate Configuration

    terraform validate

## Plan Changes (Save to File)

    terraform plan -out=tfplan

## Review Plan

Review the plan output to ensure all changes are expected.

## Apply Infrastructure

    terraform apply tfplan

This ensures Terraform applies exactly what was planned, with no surprises.

------------------------------------------------------------------------

# 🔥 Production Enhancements

-   HTTPS with Google Managed SSL
-   Cloud Armor (WAF + DDoS protection)
-   Cloud Monitoring Alerts
-   Blue-Green Deployment
-   Secret Manager Integration
-   OIDC-based GitHub Authentication

------------------------------------------------------------------------

# 🎯 Interview Summary

This project provisions a production-ready 3-tier architecture in GCP
using modular Terraform.

Traffic enters through a Global HTTP Load Balancer and is distributed
across a Managed Instance Group deployed in private subnets.

Cloud NAT enables secure outbound internet access.

Cloud SQL runs with private IP configuration ensuring database
isolation.

Terraform state is stored remotely in GCS with versioning enabled.

Infrastructure provisioning is automated using GitHub Actions.

This architecture ensures:

-   High availability
-   Scalability
-   Security isolation
-   Operational efficiency
