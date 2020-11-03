##nat gw
resource "aws_eip" "nat" {
	vpc = "true"
	tags = {
		name = "natGW"
	}
}

resource "aws_nat_gateway" "raytech_natGW" {
	allocation_id = "${aws_eip.nat.id}"
	subnet_id = "${aws_subnet.pub-subnet-1.id}"
	depends_on = ["aws_internet_gateway.raytech_IGW"]
	tags = {
		name = "raytech_nat"
	}
}

## vpc setup for nat
resource "aws_route_table" "raytech_privRT" {
	vpc_id = "${aws_vpc.raytech_prod-vpc.id}"
	route {
		cidr_block = "0.0.0.0/0"
		nat_gateway_id = "${aws_nat_gateway.raytech_natGW.id}"
	}
	tags = {
  		name = "raytech_privRT"
 	}
}

###route association private
resource "aws_route_table_association" "priv-subnet-4" {
	subnet_id = "${aws_subnet.priv-subnet-4.id}"
	route_table_id = "${aws_route_table.raytech_privRT.id}"
}

resource "aws_route_table_association" "priv-subnet-5" {
        subnet_id = "${aws_subnet.priv-subnet-5.id}"
        route_table_id = "${aws_route_table.raytech_privRT.id}"
}

resource "aws_route_table_association" "priv-subnet-6" {
        subnet_id = "${aws_subnet.priv-subnet-6.id}"
        route_table_id = "${aws_route_table.raytech_privRT.id}"
}
