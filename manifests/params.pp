# # Class monit::params

class monit::params {
  case $osfamily {
    'Debian': {
      $monit_conf_file = '/etc/monit/monitrc'
      $log_file = '/var/log/monit.log'
      $id_file = '/var/lib/monit/id'
      $state_file = '/var/lib/monit/state'
      $include_dir = '/etc/monit/conf.d'
      $events_dir = '/var/lib/monit/events'
      $check_swap = true
    }
    'RedHat': {
      $monit_conf_file = '/etc/monit.conf'
      $log_file = '/var/log/monit'
      $include_dir = '/etc/monit.d'
      $events_dir = '/var/monit'
      if $lsbmajdistrelease == 5 {
        #CentOS 5 package doesn't have swap support
        $check_swap = false
      } else {
        $id_file = '/var/.monit.id'
        $check_swap = true
      }
    }
  }
}
