class svn
{
  package {
    'python-software-properties':
    ensure => installed,
  }

  # we need to get svn 1.7 so it lines up with the mac version. Ubuntu defaults to 1.6 so we have to jump through hoops
  # to go find add a repo that has 1.7 for ubuntu precise.
  exec { 'add-launchpad-repo':
    command => 'sudo add-apt-repository "deb http://ppa.launchpad.net/svn/ppa/ubuntu precise main"',
    path  => "/usr/bin/",
    unless => '/bin/grep "ppa/ubuntu precise main" /etc/apt/sources.list',
    require => Package['python-software-properties'],
  }

  exec { 'add-launchpad-repo-update':
    command => '/usr/bin/apt-get -y update',
    refreshonly => true,
  }

  Exec['add-launchpad-repo'] ~> Exec['add-launchpad-repo-update'] # ~ is for notifications

  package {
    'subversion':
        ensure => 'installed',
        require => Exec['add-launchpad-repo-update'] # requires on exec always seem to work, even if the execs aren't executed...
  }
}