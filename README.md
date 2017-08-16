# CC test checklist


## manual task:
  - create a hosted zone for schoolofitalian.org (could be done using terraform)
  - take the Name servers and add them on godaddy.com

- use terraform to get the letsencrypt certificate


- puppet
  - install drupal 7 + civicrm
  - install nginx
  - install drush
  - install mysql

- ansible

## OS

- Ubuntu Xenial 16.04 LTS

# to add the Puppet apt repo on Xenial

```bash
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
sudo dpkg -i puppetlabs-release-pc1-xenial.deb
sudo apt update
```

## Resources used

[1](https://github.com/bighappyface/drupal-cloud-tutorial/blob/master/drupalstack/manifests/drupalcore.pp)

[2](https://lakshminp.com/just-enough-ansible-drupal?utm_source=drupal-planet&utm_medium=rss&utm_campaign=articles)


