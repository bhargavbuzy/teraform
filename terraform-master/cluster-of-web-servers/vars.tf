# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = 80
}


variable default_keypair_public_key {
  description = "Public Key of the default keypair"
}

variable region {
  default = "us-west-2"
}

variable zone {
  default = "us-west-2a"
}



variable vpc_cidr {
  default = "10.43.0.0/16"
}

variable subnet_cidr {
  default = "10.43.20.0/24"
}
