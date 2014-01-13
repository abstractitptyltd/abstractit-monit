# Define: monit::process
#
# add a process for monit to monitor
#
# Sample Usage:
#
define monit::process (
  $process = '',
  $start = '',
  $stop = '',
  $restarts = '5',
  $cycles = '5',
  $restart_action = 'timeout',
  $pidfile = '',
  $host = '',
  $port = '',
  $protocol = '',
  $host_tests = '3',
  $host_cycles = '3',
  $host_action = 'restart',
  $template = 'monit/process.erb',
) {

  $real_process = $process ? {
    ''      => $name,
    default => $process,
  }
  $real_pidfile = $pidfile ? {
    ''      => "/var/run/${name}.pid",
    default => $process,
  }
  $real_start = $start ? {
    ''      => "service ${real_process} start",
    default => $start,
  }
  $real_stop = $stop ? {
    ''      => "service ${real_process} stop",
    default => $stop,
  }

  file { "/etc/monit/conf.d/${name}.monitrc":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($template),
    notify  => Service['monit'],
  }

}
