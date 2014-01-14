# Class: monit::install
#
# for managing the monit service
#
class monit::install {
  package { 'monit':
    ensure => installed,
  }
}
