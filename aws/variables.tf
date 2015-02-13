variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "key_name" {}
variable "key_file" {}
variable "zone_id" {}
variable "mesos_dns" {}

# Official Ubuntu Cloud Images
# https://cloud-images.ubuntu.com/trusty/current/

variable "amis" {
    default = {
        us-east-1 = "ami-4c7a3924"
        us-west-2 = "ami-17471c27"
        us-west-1 = "ami-84bba3c1"
    }
}
