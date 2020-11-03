resource "aws_instance" "bashton" {
	ami = "${lookup(var.AMIS, var.AWS_REGION)}"
	instance_type = "${var.INSTANCE_TYPE}"
#	count = "${var.INSTANCE_COUNT}"
	provisioner "local-exec" {
		command = "echo ${aws_instance.bashton.private_ip} >> private_ips.txt"
}
	root_block_device {
		volume_type = "gp2"
		volume_size = "9"
	
	}
	
	tags = {
		Name = "jump-server"
	}

	#define subnet
	subnet_id = "${aws_subnet.pub-subnet-1.id}"

	#security group
	vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]
	
	#the publish ssh key
	key_name = "${aws_key_pair.myBashtonKey.key_name}"

}

output "ip" {
	value = "${aws_instance.bashton.public_ip} >> bashton_public_ips.txt"
}

##privateInstance

resource "aws_instance" "app-server" {
        ami = "${lookup(var.AMIS, var.AWS_REGION)}"
        instance_type = "${var.INSTANCE_TYPE}"
        count = "${var.INSTANCE_COUNT}"
        provisioner "local-exec" {
                command = "echo ${aws_instance.bashton.private_ip} >> private_ips.txt"
}
        root_block_device {
                volume_type = "gp2"
                volume_size = "9"

        }
	
	tags = {
		Name = "app-server1"
	}

        #define subnet
        subnet_id = "${aws_subnet.priv-subnet-4.id}"

        #security group
        vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]

        #the publish ssh key
        key_name = "${aws_key_pair.myBashtonKey.key_name}"

}


resource "aws_instance" "app-server2" {
        ami = "${lookup(var.AMIS, var.AWS_REGION)}"
        instance_type = "${var.INSTANCE_TYPE}"
#        count = "${var.INSTANCE_COUNT}"
        provisioner "local-exec" {
                command = "echo ${aws_instance.bashton.private_ip} >> private_ips.txt"
}
        root_block_device {
                volume_type = "gp2"
                volume_size = "9"

        }
	
	 tags = {
                Name = "app-server2"
        }

        #define subnet
        subnet_id = "${aws_subnet.priv-subnet-5.id}"

        #security group
        vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]

        #the publish ssh key
        key_name = "${aws_key_pair.myBashtonKey.key_name}"

}



####


#resource "aws_ebs_volume" "ebs-volume-1" {
#	availability_zone = "ap-south-1a"
#	size = "10"
#	type = "gp2"
#	tags = {
#	Name = "extra volume data"
#	}
#}

#resource "aws_volume_attachment" "ebs-volume-1-attachment" {
#	device_name = "${var.INSTANCE_DEVICE_NAME}"
#	volume_id = "${aws_ebs_volume.ebs-volume-1.id}"
#	instance_id = "${aws_instance.bashton.id}"
#}

