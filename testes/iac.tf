provider "aws" {
    region = "us-east-1"
}
resource "aws_instance" "teste" {
ami = "ami-teste123"
instance_type = "t2.micro"  
}