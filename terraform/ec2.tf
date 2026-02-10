# 1. Fetch the latest Ubuntu 24.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's AWS Account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

# 2. AWS Key Pair for SSH Access
resource "aws_key_pair" "pod_deployer" {
  key_name   = "pod-key"
  public_key = file("pod-key.pub")
}

# 3. Security Group Configuration
resource "aws_security_group" "pod_sg" {
  name        = "pod-server-sg"
  vpc_id      = aws_vpc.pod_vpc.id

  # Inbound Rule: SSH Access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound Rule: HTTP Access (For Frontend)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound Rule: Backend API Access (Update port if your backend uses a different one, e.g., 8080)
  ingress {
    from_port   = 5000 
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rule: Allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 4. EC2 Instance Definition
resource "aws_instance" "pod_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.small" # Upgraded to 2GB RAM to avoid build/resource crashes
  key_name               = aws_key_pair.pod_deployer.key_name
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.pod_sg.id]
  associate_public_ip_address = true

  # Storage Configuration: Increased to 20GB to accommodate Docker images and builds
  root_block_device {
    volume_size = 20 
    volume_type = "gp3"
  }

  tags = {
    Name = "pod-industrial-server"
  }
}

# 5. Output the Public IP address of the server
output "server_public_ip" {
  value = aws_instance.pod_server.public_ip
}