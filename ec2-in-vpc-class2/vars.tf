#variable "AWS_ACCESS_KEY" {}
#variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
	default = "us-east-1"
}

variable "AMIS" {
	type = "map"
	default = {
		us-east-1 = "ami-0817d428a6fb68645"
		ap-south-1 = "ami-0cda377a1b884a1bc"
 }
}

variable "PATH_TO_PRIVATE_KEY" {
	default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
	default = "mykey.pub"
}

variable "INSTANCE_DEVICE_NAME" {
	default = "/dev/xvdh"
}

variable "INSTANCE_COUNT" {
	default = "2"
}

variable "INSTANCE_TYPE" {
	default = "t2.micro"
}

variable "AZ" {
	type = list(string)
	default = ["us-east-1a","us-east-1b","us-east-1c"]
}
