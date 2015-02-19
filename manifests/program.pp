# Define: monit::program
#
# add a program for monit to monitor
#
# Sample Usage:
#
define monit::program (
  $program        = '',
  $path           = '',
  $start          = '',
  $stop           = '',
  $restarts       = '5',
  $cycles         = '5',
  $restart_action = 'timeout',
  $status         = '',
  $status_tests   = '3',
  $status_cycles  = '3',
  $status_action  = 'restart',
  $host           = '',
  $port           = '',
  $protocol       = '',
  $type           = '',
  $host_tests     = '3',
  $host_cycles    = '3',
  $host_action    = 'restart',
  $template       = 'monit/program.erb',) {
  include monit
  $include_dir  = $monit::include_dir
  $service_bin  = $monit::service_bin

  $real_program = $program ? {
    ''      => $name,
    default => $program,
  }
  $real_start   = $start ? {
    ''      => "${service_bin} ${real_program} start",
    default => $start,
  }
  $real_stop    = $stop ? {
    ''      => "${service_bin} ${real_program} stop",
    default => $stop,
  }

  file { "${include_dir}/${name}_program.monitrc":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($template),
    notify  => Class['monit::service'],
    require => Class['monit::install'],
  }

}
