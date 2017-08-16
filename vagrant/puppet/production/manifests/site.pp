# install mysql, set root password
# create 2 users (drupal, civicrm)
# create 2 databases (drupal, civicrm)
# grant access to the respective DB
# install drupal
# install civicrm
# do all the rest

class create_mariadb {
  notice(lookup('db_root_password'))

  class {'::mysql::server':
    root_password           => lookup('db_root_password'),
    remove_default_accounts => true
  }

  mysql::db {'drupal':
      user     => 'drupal',
      password => $facts['mysql_drupal_password'],
      host     => 'localhost',
      grant    => ['ALL'],
  }

  mysql::db {'civicrm':
    user     => 'civicrm',
    password => $facts['mysql_civicrm_password'],
    host     => 'localhost',
    grant    => ['ALL'],
  }
}


class { 'create_mariadb': }
