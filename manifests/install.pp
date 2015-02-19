# Class: monit::install
#
# for managing the monit service
#
class monit::install (
  $version = installed) {
  package { 'monit':
    ensure => $version,
  }
}
