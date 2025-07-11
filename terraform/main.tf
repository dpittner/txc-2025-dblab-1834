module "lab_base" {
  source = "git::https://github.ibm.com/cloud-labs/reusable.git//terraform/modules/base"

  basename = var.basename
  tags     = var.tags
}

module "lab_idp" {
  source = "git::https://github.ibm.com/cloud-labs/reusable.git//terraform/modules/idp"

  basename          = var.basename
  title             = var.title
  region            = var.region
  resource_group_id = module.lab_base.resource_group_id

  user_count        = var.user_count
  user_prefix       = var.user_prefix

  tags              = var.tags
  # comment the following if you want to use a trusted profile instead or real users
  cloud_user_strategy = "STATIC"
}
