resource "aws_instance" "raytech" {
	ami = "${lookup(var.AMIS, var.AWS_REGION)}"
	instance_type = "t2.micro"
	provisioner "local-exec" {
		command = "echo ${aws_instance.raytech.private_ip} >> private_ips.txt"
 }
}

output "ip" {
	value = "${aws_instance.raytech.public_ip}"
}
