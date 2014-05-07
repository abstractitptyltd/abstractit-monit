# Class: monit::service
#
# for managing the monit service
#

class monit::service (
  $ensure = $monit::params::ensure,
  $enable = $monit::params::enable,
) inherits monit::params {
  service { 'monit':
    ensure => $ensure,
    enable => $enable,
  }
}
