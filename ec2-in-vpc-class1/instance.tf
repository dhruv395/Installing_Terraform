resource "aws_instance" "bashton" {
	ami = "${lookup(var.AMIS, var.AWS_REGION)}"
	instance_type = "t2.micro"
	provisioner "local-exec" {
		command = "echo ${aws_instance.bashton.private_ip} >> private_ips.txt"
}

	#define subnet
	subnet_id = "${aws_subnet.ap-south-1a-pub-sub.id}"

	#security group
	vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]
	
	#the publish ssh key
	key_name = "${aws_key_pair.myBashtonKey.key_name}"

}

output "ip" {
	value = "${aws_instance.bashton.public_ip} >> bashton_public_ips.txt"
}


resource "aws_ebs_volume" "ebs-volume-1" {
	availability_zone = "ap-south-1a"
	size = "10"
	type = "gp2"
	tags = {
	Name = "extra volume data"
	}
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
	device_name = "/dev/xvdh"
	volume_id = "${aws_ebs_volume.ebs-volume-1.id}"
	instance_id = "${aws_instance.bashton.id}"
}

