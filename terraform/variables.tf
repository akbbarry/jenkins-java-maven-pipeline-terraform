variable vpc_cidr_block {
    default = "10.0.0.0/16"
}
variable subnet_cidr_block {
    default = "10.0.10.0/24"
}
variable avail_zone {
    default = "us-east-2b"
}
variable env_prefix {
    default = "dev"
}
variable "my_ip" {
  default = "172.56.163.221/32"
}
variable jenkins_ip {
    default = "142.93.119.201/32"
}
variable instance_type {
    default = "t3.micro"
}
variable region {
    default = "us-east-2"
}