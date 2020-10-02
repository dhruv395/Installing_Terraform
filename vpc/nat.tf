##nat gw
resource "aws_eip" "nat" {
	vpc = "true"
}

resource "aws_nat_gateway" "raytech_natGW" {
	allocation_id = "${aws_eip.nat.id}"
	subnet_id = "${aws_subnet.ap-south-1a-pub-sub.id}"
	depends_on = ["aws_internet_gateway.raytech_IGW"]
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

##route association private
resource "aws_route_table_association" "ap-south-1a-priv-subRT" {
	subnet_id = "${aws_subnet.ap-south-1a-priv-sub.id}"
	route_table_id = "${aws_route_table.raytech_privRT.id}"
}

resource "aws_route_table_association" "ap-south-1b-priv-subRT" {
        subnet_id = "${aws_subnet.ap-south-1b-priv-sub.id}"
        route_table_id = "${aws_route_table.raytech_privRT.id}"
}

resource "aws_route_table_association" "ap-south-1c-priv-subRT" {
        subnet_id = "${aws_subnet.ap-south-1c-priv-sub.id}"
        route_table_id = "${aws_route_table.raytech_privRT.id}"
}
