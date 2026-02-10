# vpc.tf

# 1. VPC 
resource "aws_vpc" "pod_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "pod-vpc"
  }
}

# 2. Public Subnet (Frontend/Load Balancer)
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.pod_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "pod-public-subnet"
  }
}

# 3. Private Subnet (Backend)
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.pod_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "pod-private-subnet"
  }
}

# 4. Internet Gateway (Public Internet)
resource "aws_internet_gateway" "pod_igw" {
  vpc_id = aws_vpc.pod_vpc.id

  tags = {
    Name = "pod-igw"
  }
}

# 5. Route Table (Public)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.pod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pod_igw.id
  }

  tags = {
    Name = "pod-public-rt"
  }
}

# 6. Route Table Association
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}