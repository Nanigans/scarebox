#
# base.pp
# Build Vagrant box configuration from modules
#
# vagrant-javadev-box
# https://github.com/rob-murray/vagrant-javadev-box
#


# Install latest jdk
class { 'java':
  distribution => 'jdk',
  version      => 'latest',
}

# create a simple hostname and ip host entry
host { 'tinbox.nanigans.com':
  ip => '192.168.56.102',
  host_aliases => 'tinbox',
}

# create a simple hostname and ip host entry
host { 'adbox.nanigans.com':
  ip => '192.168.56.101',
  host_aliases => 'adbox',
}

# Install Maven to the vagrant users home dir and shell

# SCAREBOX doesn't need Maven right now.  If you need it, uncomment this.

package {
  'maven2':
  ensure => 'installed',
}


include svn
