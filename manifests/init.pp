# # Class monit
# manage and configure the monit service

class monit (
  $ensure      = $monit::params::ensure,
  $enable      = $monit::params::enable,
  $from_email  = '',
  $alert_email = '',
  $mailserver  = '',
  $check_local = $monit::params::check_local,
  $check_disk  = $monit::params::check_disk,) inherits monit::params {
  class { 'monit::install': } ->
  class { 'monit::config':
    from_email  => $from_email,
    alert_email => $alert_email,
    mailserver  => $mailserver,
    check_local => $check_local,
    check_disk  => $check_disk,
  } ~>
  class { 'monit::service':
    ensure => $ensure,
    enable => $enable,
  } ->
  Class['monit']

}
