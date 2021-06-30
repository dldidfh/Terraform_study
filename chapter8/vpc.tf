resource "aws_vpc" "main" {
	cidr_block = "10.0.0.0/16"

	tags = {
	Name = "terraform-inflear"
	}
}
resource "aws_subnet" "public_subnet" {
	vpc_id = aws_vpc.main.id
	cidr_block = "10.0.0.0/24"
	tags = {
		Name = "terraform-inflearn-public"
	}
	availability_zone = "ap-northeast-2a"
}
resource "aws_subnet" "private_subnet" {
	vpc_id = aws_vpc.main.id
        cidr_block = "10.0.10.0/24"
	tags = {
                Name = "terraform-inflearn-private"
        }

}
resource "aws_internet_gateway" "igw" {
	vpc_id = aws_vpc.main.id
	tags = {
	Name = "terraform-igw"
	}
}


resource "aws_eip" "nat_1" {
	vpc = true

	lifecycle{
		create_before_destroy = true
	}
}
resource "aws_nat_gateway" "mat_gateway_1"{
	allocation_id = aws_eip.nat_1.id

	# Private subnet 이 아이라 public sybnet을 연결해야함 
	subnet_id = aws_subnet.public_subnet.id

	tags = {
		Name = "Terraform-NAT-GW-1"
	}
}

resource "aws_route_table" "public" {
	vpc_id = aws_vpc.main.id
	
	tags = {
		Name = "terraform-rt-public"
	}
	route {
                cidr_block = "0.0.0.0/0"
                gateway_id = aws_internet_gateway.igw.id
        }

}

resource "aws_route_table" "private" {
	vpc_id = aws_vpc.main.id

	 tags = {
                Name = "terraform-rt-private"
        }
}

resource "aws_route_table_association" "route_table_association_public" {
	subnet_id = aws_subnet.public_subnet.id
	route_table_id = aws_route_table.public.id

}
resource "aws_route_table_association" "route_table_association_private" {
	subnet_id = aws_subnet.private_subnet.id
	route_table_id = aws_route_table.private.id
}


resource "aws_route" "private_route" {
	route_table_id = aws_route_table.private.id
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id = aws_nat_gateway.mat_gateway_1.id
}

# resource "aws_vpc_endpoint" "s3" {
#	vpc_id = aws_vpc.main.id
#	service_name = "com.amazonaws.ap-northeast-2.s3"
#	tags = {
#		Enviroment = "terraform_test"
#	}
#}
##resource "aws_route" "

