output "public_ip" {
  value = "${aws_instance.EC2-cctest.public_ip}"
}

output "certificate_pem" {
  value = "${module.acme-cert.certificate_pem}"
}

output "certificate_issuer_pem" {
  value = "${module.acme-cert.certificate_issuer_pem}"
}

output "certificate_privkey" {
  value = "${module.acme-cert.certificate_private_key_pem}"
}

output "elb_name" {
  value = "${aws_elb.web.dns_name}"
}

output "mysql_root_password_enc" {
  value = "${data.aws_kms_ciphertext.mysql_root_password.ciphertext_blob}"
}

output "mysql_drupal_password_enc" {
  value = "${data.aws_kms_ciphertext.mysql_drupal_password.ciphertext_blob}"
}

output "mysql_civicrm_password_enc" {
  value = "${data.aws_kms_ciphertext.mysql_civicrm_password.ciphertext_blob}"
}
