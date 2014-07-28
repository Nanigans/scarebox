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


include svn
include wget

file { [ "/vagrant/puppet/modules/maven/files" ]:
  ensure => "directory",
}

# Install Maven to the vagrant users home dir and shell
# if we just apt-get maven then it installs all kinds of dependencies and screws with java version.
# So BLERG we wget the tar
wget::fetch { "download Maven tar":
  source      => "http://mirror.reverse.net/pub/apache/maven/maven-3/3.2.2/binaries/apache-maven-3.2.2-bin.tar.gz",
  destination => "/vagrant/puppet/modules/maven/files/apache-maven-3.2.2-bin.tar.gz"
}

include maven

maven::setup { "maven":
  ensure        => 'present',
  source        => 'apache-maven-3.2.2-bin.tar.gz',
  deploymentdir => '/home/vagrant/apache-maven',
  user          => 'vagrant',
  pathfile      => '/home/vagrant/.bashrc'
}
