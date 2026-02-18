# Security Group for Bastion Host (Public Subnet)
# This acts as the gateway for our private servers
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH access to Bastion Host"
  vpc_id      = aws_vpc.main.id

  # Allow SSH from anywhere (Industrial tip: limit this to your IP for better security)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # Allow all outgoing traffic (To talk to Private Subnet)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Bastion-SG"
  }
}

# Security Group for Backend (Private Subnet)
resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Allow traffic from Bastion, Nginx and RDS"
  vpc_id      = aws_vpc.main.id

  # Modified SSH: Only allow connections COMING FROM the Bastion Security Group
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id] 
  }

  # Spring Boot Port - Allow traffic within the VPC
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Backend-SG"
  }
}