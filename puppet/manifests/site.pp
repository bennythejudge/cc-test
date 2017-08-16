# install mysql, set root password
# create 2 users (drupal, civicrm)
# create 2 databases (drupal, civicrm)
# grant access to the respective DB
class create_mariadb {
  class {'::mysql::server':
    root_password           => lookup('db_root_password'),
    remove_default_accounts => true
  }

  mysql::db {'drupal':
      user     => 'drupal',
      password => lookup('db_drupal_password'),
      host     => 'localhost',
      grant    => ['ALL'],
  }

  mysql::db {'civicrm':
    user     => 'civicrm',
    password => lookup('db_civicrm_password'),
    host     => 'localhost',
    grant    => ['ALL'],
  }
}

class { 'nginx': }

# # install drupal
# class install_drupal {
#   $drupal_version = '7.18'

#   file { '/opt/DrupalCore': ensure => directory, }

#   exec { 'get-drupal':
#     command => "wget http://ftp.drupal.org/files/projects/drupal-${drupal_version}.tar.gz -P /opt/DrupalCore",
#     path    => ['/usr/bin'],
#     creates => "/opt/DrupalCore/drupal-${drupal_version}.tar.gz",
#     require => File['/opt/DrupalCore'],
#   }

#   exec { 'uncompress-drupal':
#     command => "tar -xzf /opt/DrupalCore/drupal-${drupal_version}.tar.gz -C /opt/DrupalCore",
#     path    => ['/bin'],
#     creates => "/opt/DrupalCore/drupal-${drupal_version}",
#     require => Exec['get-drupal'],
#   }

#   file { '/opt/DrupalCore/current':
#     ensure  => link,
#     target  => "/opt/DrupalCore/drupal-${drupal_version}",
#     require => Exec['uncompress-drupal']
#   }
# }

# # install PHP
# class install_php {
#   package { ['php5', 'php5-mysql', 'php5-gd', 'libapache2-mod-php5']: ensure => present, }
# }

# # install nginx


# # install civicrm
# # do all the rest




class { 'create_mariadb': }

# class { 'install_drupal': }

# class { 'install_php': }
