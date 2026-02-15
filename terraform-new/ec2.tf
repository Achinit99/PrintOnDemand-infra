resource "aws_key_pair" "deployer" {
  key_name   = "prod-key"
  public_key = file("prod-key.pub")
}

resource "aws_instance" "backend_server" {
  ami           = "ami-022d03f649d12a49d" # Amazon Linux 2 (ap-south-1 region)
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private.id
  key_name      = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  tags = {
    Name = "Backend-Server-Industrial"
  }
}