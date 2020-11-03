#internet vpc
resource "aws_vpc" "raytech_prod-vpc" {
	cidr_block = "10.0.0.0/16"
	instance_tenancy = "default"
	enable_dns_support = "true"
	enable_dns_hostnames = "true"
	enable_classiclink = "false"
	tags =  {
  		  Name = "raytech_prod-vpc"
	}
}

#subnets
resource "aws_subnet" "pub-subnet-1" {
	vpc_id = "${aws_vpc.raytech_prod-vpc.id}"
	cidr_block = "10.0.1.0/24"
	map_public_ip_on_launch = "true"
	availability_zone = "${var.AZ[0]}"
	tags = {
		Name = "pub-sub_${var.AZ[0]}"
 	}
}

resource "aws_subnet" "pub-subnet-2" {
        vpc_id = "${aws_vpc.raytech_prod-vpc.id}"
        cidr_block = "10.0.2.0/24"
        map_public_ip_on_launch = "true"
        availability_zone = "${var.AZ[1]}"
        tags = {
                Name = "pub-sub_${var.AZ[1]}"
        }
}

resource "aws_subnet" "pub-subnet-3" {
        vpc_id = "${aws_vpc.raytech_prod-vpc.id}"
        cidr_block = "10.0.3.0/24"
        map_public_ip_on_launch = "true"
        availability_zone = "${var.AZ[2]}"
        tags = {
                Name = "pub-sub_${var.AZ[2]}"
        }
}

resource "aws_subnet" "priv-subnet-4" {
        vpc_id = "${aws_vpc.raytech_prod-vpc.id}"
        cidr_block = "10.0.4.0/24"
        map_public_ip_on_launch = "true"
        availability_zone = "${var.AZ[0]}"
        tags = {
                Name = "priv-sub_${var.AZ[0]}"
        }
}

resource "aws_subnet" "priv-subnet-5" {
        vpc_id = "${aws_vpc.raytech_prod-vpc.id}"
        cidr_block = "10.0.5.0/24"
        map_public_ip_on_launch = "true"
        availability_zone = "${var.AZ[1]}"
        tags = {
                Name = "priv-sub_${var.AZ[1]}"
        }
}

resource "aws_subnet" "priv-subnet-6" {
        vpc_id = "${aws_vpc.raytech_prod-vpc.id}"
        cidr_block = "10.0.6.0/24"
        map_public_ip_on_launch = "true"
        availability_zone = "${var.AZ[2]}"
        tags = {
                Name = "priv-sub_${var.AZ[2]}"
        }
}


resource "aws_internet_gateway" "raytech_IGW" {
	vpc_id = "${aws_vpc.raytech_prod-vpc.id}"
	tags = {
		Name = "raytech_IGW"
	}
}


##route tables
resource "aws_route_table" "raytech_pubRT" {
	vpc_id = "${aws_vpc.raytech_prod-vpc.id}"
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.raytech_IGW.id}"
  }
	tags = {
		Name = "raytech_pubRT"
	}
}

##route association of public subnet
resource "aws_route_table_association" "pub-subnet-1" {
	subnet_id = "${aws_subnet.pub-subnet-1.id}"
	route_table_id = "${aws_route_table.raytech_pubRT.id}"
}

resource "aws_route_table_association" "pub-subnet-2" {
        subnet_id = "${aws_subnet.pub-subnet-2.id}"
        route_table_id = "${aws_route_table.raytech_pubRT.id}"
}

resource "aws_route_table_association" "pub-subnet-3" {
        subnet_id = "${aws_subnet.pub-subnet-3.id}"
        route_table_id = "${aws_route_table.raytech_pubRT.id}"
}

