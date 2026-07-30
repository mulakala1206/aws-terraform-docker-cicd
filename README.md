# AWS Terraform Docker CI/CD

This repository contains DevOps assignments covering Infrastructure as Code, Containerization, and CI/CD.

## Repository Structure

terraform/
docker/
jenkins/github-actions/

## Week 1 Infrastructure Provisioning

Provision AWS infrastructure using Terraform.

### Resources Created

- EC2 Instance (Free Tier Eligible)
- Security Group
- SSH (22)
- HTTP (80)

##### Week1 Assignment Output

<img width="1470" height="956" alt="image" src="https://github.com/user-attachments/assets/3a30f5a4-ee0c-4903-8754-6098e31e430b" />


# Week 2 - Server Configuration

Automatically configure the EC2 instance by installing Docker after the infrastructure is provisioned.

## Objective

Automate Docker installation on the EC2 instance using a shell script executed through Terraform user data.

## Tasks Completed

- Created a shell script to install Docker.
- Configured Terraform to execute the script using EC2 user data.
- Installed and started the Docker service automatically during instance launch.
- Enabled Docker to start automatically on system boot.
- Verified that Docker was successfully installed and running on the EC2 instance.

## Technologies Used

- AWS EC2
- Terraform
- Shell Script (Bash)
- Docker

##### Week2 Assignment Output

<img width="1449" height="859" alt="Screenshot 2026-07-10 at 1 49 43 PM" src="https://github.com/user-attachments/assets/a90b9409-946e-469b-938d-e8bc8425fb56" />


# Week 3 - Container Deployment

Deploy an NGINX Docker container on the EC2 instance and expose it on port 80.

## Objective

Automate the deployment of an NGINX Docker container using a shell script executed through Terraform user data.

## Tasks Completed

- Pulled the latest official NGINX Docker image.
- Removed any existing NGINX container to ensure idempotent deployment.
- Deployed the NGINX container in detached mode.
- Exposed container port **80** to the EC2 instance port **80**.
- Configured the container to restart automatically after system reboot.
- Verified the application was accessible through the EC2 Public IP in a web browser.

##### Week3 Assignment Output

<img width="1466" height="948" alt="Screenshot 2026-07-18 at 10 46 38 AM" src="https://github.com/user-attachments/assets/3bf3db7c-647e-4e8b-ae3a-3449b2ae5a7b" />

# Week4 - CI/CD Automation with GitHub Actions

## Objective

Automate Terraform workflows using GitHub Actions to provision AWS infrastructure without manually running Terraform commands from a local machine.

## Tasks Completed

* Created a GitHub Actions workflow using terraform.yaml.
* Configured GitHub Repository Secrets for AWS authentication:
    * AWS_ACCESS_KEY_ID
    * AWS_SECRET_ACCESS_KEY
    * AWS_REGION
* Integrated GitHub Actions with AWS using IAM credentials.
* Automated Terraform initialization using terraform init.
* Automated Terraform validation using terraform validate.
* Automated Terraform execution planning using terraform plan.
* Automated infrastructure provisioning using terraform apply -auto-approve.
* Verified successful workflow execution from the GitHub Actions dashboard.
* Demonstrated Infrastructure as Code (IaC) deployment through a CI/CD pipeline.

## Technologies Used

* GitHub Actions
* Terraform
* AWS EC2
* AWS IAM
* YAML
* Infrastructure as Code (IaC)
 
## GitHub Actions Workflow

name: Terraform CI

on:
  push:
    branches:
      - main

jobs:
  terraform:
    runs-on: ubuntu-latest

    defaults:
      run:
        working-directory: infrastructure-provisioning

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3

      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ secrets.AWS_REGION }}

      - name: Terraform Init
        run: terraform init

      - name: Terraform Validate
        run: terraform validate

      - name: Terraform Plan
        run: terraform plan

      - name: Terraform Apply
        run: terraform apply -auto-approve

## Workflow Execution

1. Developer pushes code to the main branch.
2. GitHub Actions automatically triggers the workflow.
3. Terraform initializes the AWS provider.
4. Terraform validates the configuration.
5. Terraform generates an execution plan.
6. Terraform provisions the infrastructure in AWS.
7. Deployment status is available in the GitHub Actions dashboard.

#### Week 4 Assignment Output

<img width="1470" height="956" alt="Screenshot 2026-07-29 at 6 23 20 PM" src="https://github.com/user-attachments/assets/83d5e725-9823-40cb-8d9a-11a786690cd9" />

<img width="1468" height="559" alt="Screenshot 2026-07-29 at 6 40 24 PM" src="https://github.com/user-attachments/assets/cd158b75-a7b8-4770-9836-de7d66f4c0c5" />