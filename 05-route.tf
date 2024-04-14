#route tables

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.app1.id

  route {
    cidr_block       = "0.0.0.0/0"
    nat_gateway_id   = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.app1.id

  route {
    cidr_block   = "0.0.0.0/0"
    gateway_id   = aws_internet_gateway.app1_igw.id
  }

  tags = {
    Name = "public"
  }
}

#route table associations

# Public Subnet Associations
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public_subnet.*.id)

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public.id
}



# Private Subnet Associations
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private_subnet.*.id)

  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private.id
}

