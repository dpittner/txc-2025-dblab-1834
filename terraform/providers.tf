terraform {
  required_version = ">= 1.5"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.82.1"
    }
  }
}

provider "ibm" {
  region = var.region
}
