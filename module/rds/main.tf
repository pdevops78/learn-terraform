resource "aws_db_instance" "default" {
  allocated_storage    = 20
  db_name              = "mydb"
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = jsondecode(data.vault_generic_secret.vault-secrets.data_json).rds_username
  password             = jsondecode(data.vault_generic_secret.vault_secrets.data_json).rds_password
  parameter_group_name = aws_db_parameter_group.pg.name
  skip_final_snapshot  = var.skip_final_snapshot
  db_subnet_group_name = aws_db_subnet_group.sg.name
  multi_az             = var.multi_az
  vpc_security_group_ids = [aws_security_group.sg.id]
}

resource "aws_db_parameter_group" "pg" {
  name   = "${var.env}-pg"
  family = var.family
 }

resource "aws_db_subnet_group" "sg" {
  name       = "${var.env}-sg"
  subnet_ids = var.subnet_id

  tags = {
    Name = "${var.env}-sg"
  }
}

resource "aws_security_group" "sg" {
  name                 =    "${var.env}-custom-vpc-sg"
  description          =    "Allow TLS inbound traffic and all outbound traffic"
  vpc_id               =    var.vpc_id
   ingress {
      from_port        =     3306
      to_port          =     3306
      protocol         =    "-1"
      cidr_blocks      =    ["0.0.0.0/0"]
     }
   egress {
      from_port        =     0
      to_port          =     0
      protocol         =    "-1"
      cidr_blocks      =    ["0.0.0.0/0"]
     }
  tags = {
     Name = "${var.env}-sg"
   }
}


