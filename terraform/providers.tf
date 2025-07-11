terraform {
  required_version = ">= 1.5"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.65"
    }
  }
}

provider "ibm" {
  region = var.region
}
