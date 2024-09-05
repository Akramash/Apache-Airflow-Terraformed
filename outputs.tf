# outputs.tf

# Output the public IP of the EC2 instance
output "ec2_public_ip" {
  description = "The public IP of the Airflow EC2 instance"
  value       = aws_instance.airflow_instance.public_ip
}

# Output the security group ID
output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.airflow_sg.id
}
