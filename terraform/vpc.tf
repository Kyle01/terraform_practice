resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "example-vpc"
  }
}

resource "aws_subnet" "public1" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.example.id
  availability_zone = "us-east-2a" 

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public2" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.example.id
  availability_zone = "us-east-2b" 

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "example-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}
