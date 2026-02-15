# Security Group for Backend (Private Subnet)
resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Allow traffic from Nginx and RDS"
  vpc_id      = aws_vpc.main.id

  # SSH 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # Spring Boot Port
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # VPC 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}