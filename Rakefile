task :update_bootstrap_scripts do
  base_uri  = 'https://raw.githubusercontent.com/hashicorp/puppet-bootstrap/master'
  dest_path = 'lib/puppet-git-bootstrap/support/setup/puppet'

  [
    'arch.sh',
    'centos_5_x.sh',
    'centos_6_x.sh',
    'debian.sh',
    'freebsd.sh',
    'mac_os_x.sh',
    'solaris.sh',
    'ubuntu.sh'
  ].each { |script|
    sh "wget #{base_uri}/#{script} -O #{dest_path}/#{script}"
  }
end
