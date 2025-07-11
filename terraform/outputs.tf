output "idp_url" {
  value = module.lab_idp.idp_url
}

output "user_passwords" {
  value = module.lab_idp.user_and_passwords
}

output "user_passwords_as_csv" {
  value = templatefile("./user_passwords.tmpl.csv", {
    user_passwords = module.lab_idp.user_and_passwords
  })
}

resource "local_file" "user_passwords" {
  filename = "credentials.csv"
  content = templatefile("./user_passwords.tmpl.csv", {
    user_passwords = module.lab_idp.user_and_passwords
  })
}