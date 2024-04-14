resource "aws_subnet" "public_subnet" {
  count             = 3
  vpc_id            = aws_vpc.app1.id
  cidr_block        = cidrsubnet(aws_vpc.app1.cidr_block, 8, count.index + 1)  
  availability_zone = "eu-west-1${["a", "b", "c"][count.index]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = 3
  vpc_id            = aws_vpc.app1.id
  cidr_block        = cidrsubnet(aws_vpc.app1.cidr_block, 8, count.index + 11)  
  availability_zone = "eu-west-1${["a", "b", "c"][count.index]}"

  tags = {
    Name = "private-subnet-${count.index + 11}"
  }
}
