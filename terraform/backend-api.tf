resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_ec2" {
  key_name   = "example_key"
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_instance" "fastapi-backend" {
  ami           = "ami-02f97949d306b597a"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key_ec2.key_name

  tags = {
    Name = "fastapi-backend"
  }
}
