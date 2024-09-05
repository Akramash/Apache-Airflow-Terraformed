# ec2.tf

# Security Group for Airflow EC2 instance
resource "aws_security_group" "airflow_sg" {
  vpc_id = aws_vpc.airflow_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance to run Airflow
resource "aws_instance" "airflow_instance" {
  ami           = "ami-0a0e5d9c7acc336f1"
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.airflow_sg.id]  
  key_name = "terraform-airflow"

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              export AIRFLOW_HOME="/home/ubuntu/airflow"
              sudo apt update -y
              sudo apt install -y python3-pip python3.10-venv
              python3 -m venv airflow_env
              source airflow_env/bin/activate
              pip install apache-airflow apache-airflow-providers-amazon
              airflow db init
              airflow users create --username admin --firstname Airflow --lastname Admin --role Admin --email admin@example.com --password adminpassword
              sudo mkdir -p /home/ubuntu/airflow/dags
              sudo chown -R ubuntu:ubuntu /home/ubuntu/airflow
              sudo apt install -y awscli
              aws s3 cp s3://airflow-logs-ak/ /home/ubuntu/airflow/dags --recursive
              airflow standalone
            EOF

  tags = {
    Name = "Airflow-EC2"
  }
}
