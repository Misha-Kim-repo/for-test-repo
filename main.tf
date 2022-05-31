###################Provider 설정###################
###################provider "aws" {###################
###################  access_key = "YOUR-ACCESS-KEY"###################
###################  secret_key = "YOUR-SECRET-KEY"###################
###################  region     = "ap-northeast-2"###################
###################}###################


##############VPC 생성##############
provider "aws" {
    region = "ap-northeast-2"
}

resource "aws_vpc" "main_vpc" {
    
    cidr_block = "94.0.0.0/16"

    tags = {
        Name = "for_TEST-2022-05-31"
    }
}

##############################################################################PUBLIC##############################################################################
#############PUBLIC SUBNET 생성##############
resource "aws_subnet" "public_subnet_2a" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "94.0.0.0/24"

    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "SUBNET-TEST-2022-05-31-PUB-2a"
    }
}

resource "aws_subnet" "public_subnet_2c" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "94.0.1.0/24"

    availability_zone = "ap-northeast-2c"

    tags = {
        Name = "SUBNET-TEST-2022-05-31-PUB-2c"
    }
}

#############IGW 생성##############
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main_vpc.id

    tags = {
        Name = "TEST-IGW-2022-05-31"
    }
}

#############ROUTE TABLE 생성##############
resource "aws_route_table" "route_table_for_public" {
    vpc_id = aws_vpc.main_vpc.id

    tags = {
        Name = "ROUTE-TABLE-TEST-2022-05-31-PUB"
    }
}

#############ROUTE TABLE에 SUBNET 연결##############
resource "aws_route_table_association" "route_table_association_1" {
    subnet_id = aws_subnet.public_subnet_2a.id
    route_table_id = aws_route_table.route_table_for_public.id
}

resource "aws_route_table_association" "route_table_association_2" {
    subnet_id = aws_subnet.public_subnet_2c.id
    route_table_id = aws_route_table.route_table_for_public.id
}

#############Public ROUTE TABLE에 IGW Route 설정##############
resource "aws_route" "route_1" {
    route_table_id = aws_route_table.route_table_for_public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}
##############################################################################PRIVATE##############################################################################

#############WEB용 PRIVATE SUBNET 생성##############
resource "aws_subnet" "private_subnet_2a_web" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "94.0.2.0/24"

    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "SUBNET-TEST-2022-05-31-PRI-2a_web"
    }
}

resource "aws_subnet" "private_subnet_2c_web" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "94.0.3.0/24"

    availability_zone = "ap-northeast-2c"

    tags = {
        Name = "SUBNET-TEST-2022-05-31-PRI-2c_web"
    }
}

#############WAS용 PRIVATE SUBNET 생성##############
resource "aws_subnet" "private_subnet_2a_was" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "94.0.4.0/24"

    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "SUBNET-TEST-2022-05-31-PRI-2a_was"
    }
}

resource "aws_subnet" "private_subnet_2c_was" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "94.0.5.0/24"

    availability_zone = "ap-northeast-2c"

    tags = {
        Name = "SUBNET-TEST-2022-05-31-PRI-2c_was"
    }
}

#############DB용 PRIVATE SUBNET 생성##############
resource "aws_subnet" "private_subnet_2a_db" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "94.0.6.0/24"

    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "SUBNET-TEST-2022-05-31-PRI-2a_db"
    }
}

resource "aws_subnet" "private_subnet_2c_db" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "94.0.7.0/24"

    availability_zone = "ap-northeast-2c"

    tags = {
        Name = "SUBNET-TEST-2022-05-31-PRI-2c_db"
    }
}

#############EIP 생성(for NAT)##############
resource "aws_eip" "eip_nat_2a" {
    vpc = true

    lifecycle {
     create_before_destroy = true 
    }
}

resource "aws_eip" "eip_nat_2c" {
    vpc = true
    
    lifecycle {
      create_before_destroy = true
    }
}

#############NAT생성##############
resource "aws_nat_gateway" "nat_2a" {
    allocation_id = aws_eip.eip_nat_2a.id

    subnet_id = aws_subnet.public_subnet_2a.id

    tags = {
        Name = "NAT-2a"
    }
}

resource "aws_nat_gateway" "nat_2c" {
    allocation_id = aws_eip.eip_nat_2c.id

    subnet_id = aws_subnet.public_subnet_2c.id

    tags = {
        Name = "NAT-2c"
    }
}

#############ROUTE TABLE 생성##############
resource "aws_route_table" "route_table_for_private-2a" {
    vpc_id = aws_vpc.main_vpc.id

    tags = {
        Name = "ROUTE-TABLE-TEST-2022-05-31-PRI-2a"
    }
}

resource "aws_route_table" "route_table_for_private-2c" {
    vpc_id = aws_vpc.main_vpc.id

    tags = {
        Name = "ROUTE-TABLE-TEST-2022-05-31-PRI-2c"
    }
}

#############ROUTE TABLE에 SUBNET 연결(for WEB)##############
resource "aws_route_table_association" "route_table_association_web-2a" {
    subnet_id = aws_subnet.private_subnet_2a_web.id
    route_table_id = aws_route_table.route_table_for_private-2a.id
}

resource "aws_route_table_association" "route_table_association_web-2c" {
    subnet_id = aws_subnet.private_subnet_2c_web.id
    route_table_id = aws_route_table.route_table_for_private-2c.id
}

#############ROUTE TABLE에 SUBNET 연결(for WAS)##############
resource "aws_route_table_association" "route_table_association_was-2a" {
    subnet_id = aws_subnet.private_subnet_2a_was.id
    route_table_id = aws_route_table.route_table_for_private-2a.id
}

resource "aws_route_table_association" "route_table_association_was-2c" {
    subnet_id = aws_subnet.private_subnet_2c_was.id
    route_table_id = aws_route_table.route_table_for_private-2c.id
}

#############ROUTE TABLE에 SUBNET 연결(for DB)##############
resource "aws_route_table_association" "route_table_association_db-2a" {
    subnet_id = aws_subnet.private_subnet_2a_db.id
    route_table_id = aws_route_table.route_table_for_private-2a.id
}

resource "aws_route_table_association" "route_table_association_db-2c" {
    subnet_id = aws_subnet.private_subnet_2c_db.id
    route_table_id = aws_route_table.route_table_for_private-2c.id
}

#############Private ROUTE TABLE에 NAT Route 설정##############
resource "aws_route" "route_nat_2a" {
    route_table_id = aws_route_table.route_table_for_private-2a.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_2a.id
}

resource "aws_route" "route_nat_2c" {
    route_table_id = aws_route_table.route_table_for_private-2c.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_2c.id
}

##############################################################################EC2 Instance##############################################################################

#############Bastion 서버 생성##############
resource "aws_instance" "bastion" {
    ami = "ami-0cbec04a61be382d9"
    instance_type = "t3.medium"
    subnet_id = aws_subnet.public_subnet_2a.id

    key_name = "Misha.K"
    security_groups = [aws_security_group.bastion-SG.id]

    root_block_device {
      volume_size = "8"
      volume_type = "gp3"
      delete_on_termination = true
    }
    tags = {
        Name = "Bastion"
    }
}

#############Bastion 용 SG 생성##############
resource "aws_security_group" "bastion-SG" {
    name = "Bastion-SG"
    description = "To Bastion"
    vpc_id = aws_vpc.main_vpc.id

    ingress {
        description = "TCP from MZC"
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["211.60.50.130/32"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "Bastion-SG"
    }
}

#############Bastion 용 EIP 생성##############
resource "aws_eip" "bastion-eip" {
  vpc        = true
  instance   = aws_instance.bastion.id
  depends_on = [aws_instance.bastion]
  
  tags = {
    Name = "Bastion-EIP"
  }
}
