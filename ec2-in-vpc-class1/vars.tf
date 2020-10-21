variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
	default = "ap-south-1"
}

variable "AMIS" {
	type = "map"
	default = {
		us-east-1 = "ami-0817d428a6fb68645"
		ap-south-1 = "ami-03cfb5e1fb4fac428"
 }
}

variable "PATH_TO_PRIVATE_KEY" {
	default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
	default = "mykey.pub"
}

