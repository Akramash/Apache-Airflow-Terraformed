# Terraform AWS Airflow EC2 Setup

This repository provides an automated setup of an Apache Airflow instance on AWS EC2 using Terraform. It provisions the necessary AWS infrastructure, including a Virtual Private Cloud (VPC), subnets, security groups, IAM roles, and an EC2 instance pre-configured with Airflow.

## Project Structure

- **main.tf**: Specifies the AWS provider region.
- **iam.tf**: Creates the necessary IAM roles and policies to grant the EC2 instance access to an S3 bucket.
- **ec2.tf**: Provisions an EC2 instance with Airflow, including security groups and user data for initializing Airflow.
- **outputs.tf**: Outputs important information such as the public IP of the EC2 instance and the security group ID.
- **vpc.tf**: Creates the VPC, subnets, and routing infrastructure to allow internet access for the EC2 instance.

## Prerequisites

Before using this project, ensure you have the following:

1. Terraform installed: [Terraform Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli)
2. AWS CLI installed and configured: [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
3. An AWS account with permissions to create EC2, VPC, and IAM resources.
4. A key pair available in the AWS region `us-east-1`. Make sure to update the `key_name` in `ec2.tf` with your key pair name.

## Usage

1. **Clone the repository**:

   ```bash
   git clone https://github.com/your-repo/airflow-ec2-terraform.git
   cd airflow-ec2-terraform
   ```
2. **Initialize Terraform:**
   ```bash
   terraform init
   ```
3. **Review the execution plan:**
   ```bash
   terraform plan
   ```
4. **Apply the Terraform configuration:**
   ```bash
   terraform apply
   ```
   Type yes when prompted to confirm.
5. **Outputs:**
   After a successful deployment, Terraform will display the public IP of the EC2 instance and the security group ID.

## Resources Provisioned

**IAM Role:** ec2_s3_access_role – This role allows the EC2 instance to assume permissions to access S3.

**IAM Role Policy:** Grants EC2 permissions to GetObject and ListBucket actions on the specified S3 bucket.

**Airflow EC2 Instance:** A t2.medium EC2 instance running Apache Airflow, pre-configured using user data.

**Security Group:** Allows traffic on ports 22 (SSH), 80 (HTTP), 443 (HTTPS), and 8080 (Airflow Web UI).

**VPC:** A custom VPC for isolating the Airflow setup with CIDR block 10.0.0.0/16.

**Subnets:** Two public subnets in different availability zones for high availability.

**Internet Gateway:** Provides internet access to resources within the VPC.

**Route Table:** Routes all outbound traffic to the internet gateway.

**ec2_public_ip:** The public IP of the Airflow EC2 instance.

**security_group_id:** The ID of the security group associated with the Airflow instance.

## Cleanup

To delete the resources created by this Terraform configuration:
   ```bash
   terraform destroy
   ```


