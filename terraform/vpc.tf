resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr

  tags ={
    Name = "petclinic_vpc"
  }
  }

resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  map_public_ip_on_launch = true
  cidr_block = var.subnet_cidr
  availability_zone = var.availability_zone

  tags={
    Name="petclinic_subnet"
  }
  
}

resource "aws_internet_gateway" "my_gateway" {
  vpc_id = aws_vpc.my_vpc.id

  tags={
    Name="petclinic_gateway"
  }

}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_gateway.id
  }

 
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}




