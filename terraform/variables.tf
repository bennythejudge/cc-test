# ----------------------------------------------------------------
# Variables required by letsencrypt provisioner module
# ----------------------------------------------------------------

# Let's Encrypt Account Registration Config
# -- Production
# variable "demo_acme_server_url"          { default = "https://acme.api.letsencrypt.org/directory"}
# -- Staging
variable "demo_acme_server_url" {
  default = "https://acme-staging.api.letsencrypt.org/directory"
}

# Domain against which certificate will be created
# i.e. letsencrypt-terraform.example.com
variable "demo_domain_name" {}
variable "demo_domain_subdomain" {}

# Leave blank here, supply securely at runtime 
variable "demo_acme_challenge_aws_access_key_id" {}
variable "demo_acme_challenge_aws_secret_access_key" {}
variable "demo_acme_challenge_aws_region" {}
variable "demo_acme_registration_email" {}

# mysql root account password
variable "mysql_root_password" {}
variable "mysql_drupal_password" {}
variable "mysql_civicrm_password" {}
