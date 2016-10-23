Exec {
  path => '/usr/bin:/usr/sbin/:/bin:/sbin:/usr/local/bin:/usr/local/sbin:/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin',
}

node default {
  hiera_include( 'classes' )
}
