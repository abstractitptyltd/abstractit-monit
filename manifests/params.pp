# # Class monit::params

class monit::params {
  case $osfamily {
    'Debian': {
      $monit_conf_file = '/etc/monit/monitrc'
      $log_file = '/var/log/monit.log'
      $id_file = '/var/lib/monit/id'
      $state_file = '/var/lib/monit/state'
      $include_dir = '/etc/monit/conf.d/'
      $events_dir = '/var/lib/monit/events'
    }
    'RedHat': {
      $monit_conf_file = '/etc/monit.conf'
      $log_file = '/var/log/monit/monit.log'
      $id_file = '/var/.monit.id'
      $include_dir = '/etc/monit.d/'
      $events_dir = '/var/monit'
    }
  }
}
