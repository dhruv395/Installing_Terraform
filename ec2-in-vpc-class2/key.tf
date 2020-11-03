resource "aws_key_pair" "myBashtonKey" {
	key_name = "myBashtonKey"
	public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}
