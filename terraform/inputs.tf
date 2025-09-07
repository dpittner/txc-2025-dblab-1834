variable "region" {
  default = "us-east"
}

variable "basename" {
  default = "dblab-1834"
}

variable "title" {
  default = "Automate major database version migrations without the headaches"
}

variable "tags" {
  default = [ "dblab-1834", "terraform" ]
}

variable "user_count" {
  default = 30
}

variable "user_prefix" {
  default = "dblab"
}
