from fabric.api import env, sudo, settings, hide, put, run
import ConfigParser
import os
from fabric.utils import warn
import urllib

# script dir
current_dir = os.path.dirname(os.path.abspath(__file__))
terraform_dir = "../terraform/"

#env.hosts = ['localhost']


# get started
def do_all():
  print "do_all - starts here"
  passwords_array = []
  ec2_public_ip = provision_aws_and_certificate()
  print "do_all - now here"

  env.hosts = [ec2_public_ip,]
  passwords_array = get_encrypted_passwords()
  send_passwords_to_ec2(passwords_array)
  clone_puppet_repos()
  do_puppet_apply()

# config = ConfigParser.ConfigParser()
# config.read(init)

# fabric env conf
# env.user = config.get(box, 'username')
# env.key_filename = config.get(general, 'ssh_pubkey_path')


def send_passwords_to_ec2(files):
    # files is an array, each element a /path/file
    for file in files:
      put(file,file,use_sudo=True)

# def set_up_backup(database, user, password, host, civiuser, civipwd, cividb, s3id, s3key, bucket, destination_name="compucorps3", schedule_name="s3_backup", cron="0 4 * * *"):
#     run('echo "INSERT INTO '+database+'.backup_migrate_destinations VALUES (\'1\',\''+destination_name+'\',\''+destination_name+'\',\'s3\',\'https://'+s3id+':'+urllib.quote_plus(s3key)+'@s3.amazonaws.com/'+bucket+'\',\'a:0:{}\');"|mysql --batch --user=%s --password=%s --host=%s' % (user, password, host), pty=True)
#     run('echo "INSERT INTO '+database+'.backup_migrate_schedules VALUES (\'1\',\''+schedule_name+'\',\''+schedule_name+'\',\'archive\',\''+destination_name+'\',\'\',\'default\',\'0\',\'86400\',\'1\',\'builtin\',\''+cron+'\');"|mysql --batch --user=%s --password=%s --host=%s' % (user, password, host), pty=True)
#     run('echo "INSERT INTO '+database+'.backup_migrate_sources VALUES (\'1\',\'mysql_civi\',\'Mysql civi\',\'mysql\',\'mysql://'+civiuser+':'+civipwd+'@localhost/'+cividb+'\',\'a:0:{}\');"|mysql --batch --user=%s --password=%s --host=%s' % (user, password, host), pty=True)

def provision_aws_and_certificate():
  pass

def get_encrypted_passwords():
  return ['p1', 'p2']
