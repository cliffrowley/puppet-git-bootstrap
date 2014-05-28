group { puppet:
  ensure => present,
  system => true
}

user { puppet:
  ensure   => present,
  gid      => 'puppet',
  password => '*',
  home     => '/var/lib/puppet-git',
  system   => true,
  require  => Group['puppet']
}

package { git:
  ensure => latest
}

file { 'puppet-git':
  ensure  => directory,
  path    => '/var/lib/puppet-git',
  owner   => 'puppet',
  group   => 'puppet',
  require => User['puppet']
}

exec { 'git-init-bare':
  command => 'git init --bare',
  creates => '/var/lib/puppet-git/HEAD',
  cwd     => '/var/lib/puppet-git',
  path    => '/usr/bin:/usr/local/bin',
  user    => 'puppet',
  group   => 'puppet',
  require => File['puppet-git']
}
