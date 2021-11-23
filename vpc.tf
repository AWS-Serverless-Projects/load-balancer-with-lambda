data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_vpc" "mydemovpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "my demo vpc"
  }
}

resource "aws_default_route_table" "r" {
  default_route_table_id = aws_vpc.mydemovpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "demo vpc default RT"
  }
}

resource "aws_route_table_association" "subnetfirstassoc" {
  subnet_id      = aws_subnet.subnetfirst.id
  route_table_id = aws_default_route_table.r.id
}

resource "aws_route_table_association" "subnetsecondassoc" {
  subnet_id      = aws_subnet.subnetsecond.id
  route_table_id = aws_default_route_table.r.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.mydemovpc.id

  tags = {
    Name = "demo vpc igw"
  }
}


resource "aws_subnet" "subnetfirst" {
    vpc_id = aws_vpc.mydemovpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = data.aws_availability_zones.azs.names[0]

    tags = {
        Name = "Demo VPC Subnet 01"
    }
}

resource "aws_subnet" "subnetsecond" {
  vpc_id     = aws_vpc.mydemovpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.azs.names[1]

  tags = {
    Name = "Demo VPC Subnet 02"
  }
}
