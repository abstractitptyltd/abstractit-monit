# Class: monit::config
#
# config file for monit
#
class monit::config (
  $from_email,
  $alert_email = '',
  $mailserver = "mail.${::domain}",
  $check_local = true,
  $check_disk = true,
) {
  file { 'monitrc':
    ensure  => file,
    path    => '/etc/monit/monitrc',
    content => template('monit/monitrc.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
  }

}
