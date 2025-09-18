# Kubernetes Infrastructure with Terraform

## Description

This repository contains Terraform code to provision and manage Kubernetes resources for an application using a modular structure. The main focus is on deploying an NGINX-based workload, with all Kubernetes manifests managed as YAML files and applied using the `kubernetes_manifest` resource. The infrastructure is organized into separate modules for VPC, EKS cluster, EKS add-ons, and application deployment, promoting reusability and separation of concerns.

### Code Structure

- **app/**: Contains application code and dockerfile.
- **vpc/**: Provisions the network infrastructure (VPC, subnets, etc.).
- **eks/**: Deploys the EKS (Elastic Kubernetes Service) cluster.
- **eks-addons/**: Manages EKS add-ons (e.g., CoreDNS, kube-proxy).
- **bootstrap/**: Handles initial setup and bootstrapping tasks.
- **deploy/**: Deploys application resources to the Kubernetes cluster, including:
  - Namespace creation
  - Applying manifests from the `manifests/` directory (Deployment, Service, Ingress, HPA, NetworkPolicy)

## How to Deploy the Infrastructure

1. **Install Prerequisites:**
   - [Terraform](https://www.terraform.io/downloads.html)
   - AWS CLI (configured with appropriate credentials)
   - kubectl (for manual inspection, optional)

2. **Clone the Repository:**

   ```bash
   git clone <repo-url>
   cd <repo-root>
   ```

3. **Initialize Terraform:**

   ```bash
   terraform init
   ```

   Run this in each module directory (e.g., `bootstrap/`, `vpc/`, `eks/`, `eks-addons/`, `bootstrap/`, `app/`).

4. **Apply Each Module in Order:**
   - Bootstrap:

     ```bash
     cd ../bootstrap
     terraform apply
     ```

   - VPC:

     ```bash
     cd vpc
     terraform apply
     ```

   - EKS:

     ```bash
     cd ../eks
     terraform apply
     ```

   - EKS Add-ons:

     ```bash
     cd ../eks-addons
     terraform apply
     ```

   - Deploy Application:

     ```bash
     cd ../deploy
     terraform apply
     ```

5. **Verify Deployment:**
   - Use `kubectl` to inspect resources if desired.

## Chosen Approach and Rationale

- **Modular Structure:** Each major infrastructure component is isolated in its own module for clarity and reusability.
- **YAML Manifests:** Application resources are defined as YAML files, making it easy to manage and update Kubernetes objects using standard Kubernetes syntax.
- **Terraform `kubernetes_manifest` Resource:** This allows direct application of YAML manifests, providing flexibility and reducing the need to translate YAML to HCL.
- **Namespace Management:** Ensures all resources are deployed in a dedicated namespace for isolation.

## Assumptions Made

- AWS credentials and permissions are already configured for Terraform to create and manage resources.
- The EKS cluster and networking prerequisites are provisioned before deploying application resources.
- The `vars.yaml` file contains all necessary variable values for the application module.
- The Kubernetes provider is properly configured to connect to the EKS cluster.

## Modules used

```hcl
.
└── "vpc"[git::https://github.com/mmurilo/terraform-modules.git//terraform-aws-vpc?ref=aws-vpc-v0.3.0]

.
└── "eks"[git::https://github.com/mmurilo/terraform-modules.git//terraform-aws-eks?ref=aws-eks-v0.3.0]

.
└── "eks_addons"[registry.terraform.io/aws-ia/eks-blueprints-addons/aws] 1.22.0
```

## Areas for Improvement

- **Automated Pipeline:** Add CI/CD automation for plan/apply and validation steps.
- **GitOPS CD for kubernetes Manifests:** Implement a GitOps approach using tools like ArgoCD or Flux to manage Kubernetes manifests.
- **Environment Management:** Introduce support for multiple environments using tools like Kustomize.
- **Public Endpoints:** Add support for public endpoints using AWS Load Balancer.
- **Testing:** Add automated tests for infrastructure code (e.g., using Terratest or Checkov).
- **Documentation:** Expand documentation with architecture diagrams and troubleshooting tips.
- **Security:** Implement Network policies.

---
