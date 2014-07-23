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

#maven::setup { "maven":
#  ensure        => 'present',
#  source        => 'apache-maven-3.1.1-bin.tar.gz',
#  deploymentdir => '/home/vagrant/apache-maven',
#  user          => 'vagrant',
#  pathfile      => '/home/vagrant/.bashrc'
#}
