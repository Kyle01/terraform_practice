resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_ec2" {
  key_name   = "example_key"
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow inbound HTTP/HTTPS traffic"

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
}

resource "aws_instance" "fastapi-backend" {
  ami           = "ami-02f97949d306b597a"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key_ec2.key_name

  vpc_security_group_ids = [aws_security_group.allow_web.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install -y python3.8
              alternatives --set python /usr/bin/python3.8
              curl -O https://bootstrap.pypa.io/get-pip.py
              python3 get-pip.py
              pip install fastapi uvicorn
              echo 'fastapi' > /home/ec2-user/requirements.txt
              echo 'uvicorn' >> /home/ec2-user/requirements.txt
              aws s3 cp s3://kyle-mcv-backend-s3-bucket/main.py /home/ec2-user/main.py 
              pip install -r /home/ec2-user/requirements.txt
              nohup uvicorn main:app --host 0.0.0.0 --port 80 &
              EOF

  tags = {
    Name = "fastapi-backend"
  }
}