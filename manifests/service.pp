# Class: monit::service
#
# for managing the monit service
#
class monit::service {
  service { 'monit':
    ensure => running,
    enable => true,
  }
}
