# The Let's Encrypt registration process has been included to help demo
# a single end-to-end process, however this would normally be split into
# two. See demos/acme-part-1-registration and demos/acme-part-2-core
# for an example of how this might be split
module "acme-reg" {
  source                  = "modules/acme-account-registration"
  acme_server_url         = "${var.demo_acme_server_url}"
  acme_registration_email = "${var.demo_acme_registration_email}"
}

module "dns" {
  source               = "modules/dns/direct"
  dns_domain_name      = "${var.demo_domain_name}"
  dns_domain_subdomain = "${var.demo_domain_subdomain}"
//  dns_cname_value      = "${module.aws-demo-env.demo_env_elb_dnsname}"
  dns_cname_value      = "${aws_elb.web.dns_name}"
}

module "acme-cert" {
  source                        = "modules/acme-cert-request"
  acme_server_url               = "${var.demo_acme_server_url}"
  acme_account_registration_url = "${module.acme-reg.registration_url}"
  acme_account_key_pem          = "${module.acme-reg.registration_private_key_pem}"

  #acme_certificate_common_name    = "${module.dns.fqdn_domain_name}"
  # To make use of a single direct DNS record, comment out the line 
  # above, uncomment the one below, and ensure the dns module source
  # is loaded from modules/dns/direct. This current approach has been
  # done to remove a cyclic dependency.
  acme_certificate_common_name = "${var.demo_domain_subdomain}.${var.demo_domain_name}"

  acme_challenge_aws_access_key_id     = "${var.demo_acme_challenge_aws_access_key_id}"
  acme_challenge_aws_secret_access_key = "${var.demo_acme_challenge_aws_secret_access_key}"
  acme_challenge_aws_region            = "${var.demo_acme_challenge_aws_region}"
}
