# 1. Key Pair configuration
resource "aws_key_pair" "deployer" {
  key_name   = "prod-key"
  public_key = file("prod-key.pub")
}

# 2. Bastion Host (The Gateway) - In Public Subnet
resource "aws_instance" "bastion" {
  ami           = "ami-022d03f649d12a49d" 
  instance_type = "t3.micro" # Smallest and cheapest for bastion
  
  # Make sure this is linked to your Public Subnet
  subnet_id                   = aws_subnet.public.id 
  associate_public_ip_address = true
  
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "Bastion-Host-Industrial"
  }
}

# 3. Backend Server - In Private Subnet
resource "aws_instance" "backend_server" {
  ami           = "ami-022d03f649d12a49d" 
  instance_type = "t3.micro"
  
  # Moving back to Private Subnet for security
  subnet_id                   = aws_subnet.private.id
  associate_public_ip_address = false # No direct public access
  
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  tags = {
    Name = "Backend-Server-Industrial"
  }
}

# 4. Update GitHub Secrets Automatically
# This secret tells GitHub WHERE to connect (Bastion IP)
resource "github_actions_secret" "ec2_host" {
  repository      = var.github_repo
  secret_name     = "EC2_HOST"
  plaintext_value = aws_instance.bastion.public_ip
}

# This secret tells GitHub which internal IP to jump to
resource "github_actions_secret" "ec2_private_ip" {
  repository      = var.github_repo
  secret_name     = "EC2_PRIVATE_IP"
  plaintext_value = aws_instance.backend_server.private_ip
}