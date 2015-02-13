variable "access_key" {
  description = "AWS access key"
}

variable "secret_key" {
  description = "AWS secret key"
}

variable "region" {
  description = "AWS Region"
}

variable "key_name" {
  description = "Name of AWS key pair"
}

variable "key_file" {
  description = "Path to AWS private key"
}

variable "num_slaves" {
  description = "Number of slaves to spin up"
  default = 3
}

variable "amis" {
    default = {
        us-east-1 = "ami-4c7a3924"
        us-west-2 = "ami-17471c27"
        us-west-1 = "ami-84bba3c1"
    }
}
