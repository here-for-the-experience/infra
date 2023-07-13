resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "sg-db"
  subnet_ids = var.subnet_ids
}


resource "aws_security_group" "sg_db" {
  name        = "db-security-group"
  description = "enable http access on port 5432"
  vpc_id      = var.vpc_id

  ingress {
    description = "postgres access"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "postgres access"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "userdb" {
  identifier           = "userdb"
  instance_class       = "db.m5d.large"
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "14.7"
  db_name              = "postgres"
  username             = "postgres"
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

  vpc_security_group_ids = [aws_security_group.sg_db.id]

  publicly_accessible = true
  skip_final_snapshot = true
}

resource "aws_db_instance" "vaccinedb" {
  identifier           = "vaccinedb"
  instance_class       = "db.m5d.large"
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "14.7"
  db_name              = "postgres"
  username             = "postgres"
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

  vpc_security_group_ids = [aws_security_group.sg_db.id]

  publicly_accessible = true
  skip_final_snapshot = true
}