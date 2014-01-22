# Define: monit::process
#
# add a process for monit to monitor
#
# Sample Usage:
#
define monit::process (
  $process = '',
  $service = '',
  $start = '',
  $stop = '',
  $restarts = '5',
  $cycles = '5',
  $restart_action = 'timeout',
  $pidfile = '',
  $host = '',
  $port = '',
  $protocol = '',
  $type = '',
  $host_tests = '3',
  $host_cycles = '3',
  $host_action = 'restart',
  $template = 'monit/process.erb',
) {

  $real_process = $process ? {
    ''      => $name,
    default => $process,
  }
  $real_service = $service ? {
    ''      => $name,
    default => $service ,
  }
  $real_pidfile = $pidfile ? {
    ''      => "/var/run/${name}.pid",
    default => $pidfile,
  }
  $real_start = $start ? {
    ''      => "/usr/sbin/service ${real_service} start",
    default => $start,
  }
  $real_stop = $stop ? {
    ''      => "/usr/sbin/service ${real_service} stop",
    default => $stop,
  }

  file { "/etc/monit/conf.d/${name}.monitrc":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($template),
    notify  => Class['monit::service'],
  }

}
