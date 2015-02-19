# Class: monit::service
#
# for managing the monit service
#

class monit::service (
  $ensure = 'running',
  $enable = true,) inherits monit::params {
  service { 'monit':
    ensure => $ensure,
    enable => $enable,
  }

}
