variable "ec2_instance_type" {
  type        = string
  default     = "t2.micro"
}

variable "ec2_ami_id" {
  type        = string
  default     = "ami-0df368112825f8d8f"
}

variable "ec2_root_volume_size" {
  type        = number
  default     = 8
}