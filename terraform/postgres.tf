resource "aws_db_instance" "postgres-rds" {
  identifier            = "postgres-db-rds"
  engine                = "postgres"
  engine_version        = "15.2"
  instance_class        = "db.t4g.micro"
  username              = "example_user"
  password              = "example_password"
  allocated_storage     = 20
  storage_type          = "gp2"
  backup_retention_period = 7
  publicly_accessible   = false
  backup_window         = "10:00-11:00"
  maintenance_window    = "Mon:00:00-Mon:01:00"
  skip_final_snapshot   = true


  tags = {
    Name = "postgres-db-rds"
  }
}
