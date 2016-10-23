##
## A basic class that iterates over some hashes in order to implement some
## resoures.
##

class profiles::resources (
  Hash $users   = hiera_hash( 'profiles::resources::users',   {} ),
  Hash $groups  = hiera_hash( 'profiles::resources::groups',  {} ),
  Hash $files   = hiera_hash( 'profiles::resources::files',   {} ),
  Hash $crons   = hiera_hash( 'profiles::resources::crons',   {} ),
  Hash $sshkeys = hiera_hash( 'profiles::resources::sshkeys', {} ),
) {

  $defaults = {
    ensure => present,
  }

  create_resources( user, $users, $defaults )
  create_resources( group, $groups, $defaults )
  create_resources( file, $files, $defaults )
  create_resources( cron, $crons, $defaults )
  create_resources( ssh_authorized_key, $sshkeys, $defaults )

}
