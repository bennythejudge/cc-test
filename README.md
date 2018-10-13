# CC test checklist

[![GuardRails badge](https://badges.production.guardrails.io/bennythejudge/cc-test.svg)](https://www.guardrails.io)


## task I performed manually
  - create a hosted zone for my domain (this should be done using terraform)
  - add the Amazon name servers to my domain on my registrar (godaddy)

## terraform
- this terraform code will provision the necessary AWS resources and the letsencrypt certificate
- VPC, subnet, routing table, EC2, ELB

## Puppet
- initially I wanted to use Puppet, but I decided to follow CC indication about Ansible

  - install drupal 7 + civicrm
  - install nginx
  - install drush
  - install mysql

### to add the Puppet apt repo on Xenial

```bash
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
sudo dpkg -i puppetlabs-release-pc1-xenial.deb
sudo apt update
```

## Ansible


## OS
### Vagrant
- Ubuntu Xenial 16.04 LTS


## Resources used

[drupal in the cloud](https://github.com/bighappyface/drupal-cloud-tutorial/blob/master/drupalstack/manifests/drupalcore.pp)

[drupal and ansible](https://lakshminp.com/just-enough-ansible-drupal?utm_source=drupal-planet&utm_medium=rss&utm_campaign=articles)


