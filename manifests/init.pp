class monit (
  $mailserver,
  $from_email,
  $alert_email = '',
  $check_local = true,
  $check_disk = true,
) {

  File {
    owner => 'root',
    group => 'root',
  }

  package { 'monit':
    ensure => installed
  } ->
  file { 'monitrc':
    ensure  => file,
    path    => '/etc/monit/monitrc',
    content => template('monit/monitrc.erb'),
    mode    => '0600',
  } ~>
  service { 'monit':
    ensure => running,
    enable => true,
  }

  file { 'monit.cfg':
    ensure => file,
    path   => '/usr/local/backups/monit.cfg',
    source => 'puppet:///modules/monit/monit.cfg',
    mode   => '0600',
  }

}
