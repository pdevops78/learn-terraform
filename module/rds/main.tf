resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "expense123"
  parameter_group_name = aws_db_parameter_group.pg.name
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.sg.name
  multi_az             = false
  vpc_security_group_ids = [aws_security_group.sg.id]
}

resource "aws_db_parameter_group" "pg" {
  name   = "${var.env}-pg"
  family = "mysql8.0"
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


