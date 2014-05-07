# Class: monit::config
#
# config file for monit
#

class monit::config (
  $from_email = $monit::params::from_email,
  $alert_email = $monit::params::alert_email,
  $mailserver = $monit::params::mailserver,
  $check_local = $monit::params::check_local,
  $check_disk = $monit::params::check_disk,
) inherits monit::params {

  file { 'monitrc':
    ensure  => file,
    path    => '/etc/monit/monitrc',
    content => template('monit/monitrc.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
  }

}
