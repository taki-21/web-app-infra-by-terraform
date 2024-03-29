# VPCの設定
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.app_name
  }
}

resource "aws_subnet" "public_subnets" {
  # length関数でsubnet_cidrsの数を取得し、その数ぶん繰り返し実行する
  count = length(var.public_subnet_cidrs)

  vpc_id = aws_vpc.vpc.id

  # 現在の実行回数をcount.indexで取得でき、それをインデックスとして配列から値を取得する
  availability_zone       = var.azs[count.index]

  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.app_name}-public-${var.azs_name[count.index]}"
  }
}

resource "aws_subnet" "private_subnets" {
  # length関数でsubnet_cidrsの数を取得し、その数ぶん繰り返し実行する
  count = length(var.private_subnet_cidrs)

  vpc_id = aws_vpc.vpc.id

  # 現在の実行回数をcount.indexで取得でき、それをインデックスとして配列から値を取得する
  availability_zone = var.azs[count.index]
  cidr_block        = var.private_subnet_cidrs[count.index]
  tags = {
    Name = "${var.app_name}-private-${var.azs_name[count.index]}"
  }
}

# インターネットゲートウェイをVPCにアタッチする
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.app_name
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_vpc.vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)

  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_vpc.vpc.default_route_table_id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.app_name}-private-rtb"
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)

  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = aws_route_table.private.id
}
