resource "aws_lb" "alb-balancer" {
  name               = "load-balancer"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id]

  tags = {
    Name = "load-balancer"
  }
}