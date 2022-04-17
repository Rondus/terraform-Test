variable "aws_region" {
  default = "us-west-2"
}

variable "key_name" {
  default = "classkey"
}
variable "vpc_cidr" {
  default = "172.0.0.0/24"
}
variable "subnets_cidr" {
  type    = list(string)
  default = ["172.0.0.0/26","172.0.0.64/26", "172.0.0.128/25"]
}
variable "availability_zones" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b"]
}
variable "test_ami" {
  default = "ami-0892d3c7ee96c0bf7"
}
variable "web_instance_type" {
  default = "t2.small"
}
variable "internal_instance_type" {
  default = "t2.small"
}
