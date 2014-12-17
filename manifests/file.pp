# Define: monit::file
#
# setup a file for monit to monitor
#

define monit::file (
  $path,
  $file = '',
  $timestamp = true,
  $age = undef,
  $groups = [],
  $increment = 'minutes',
  $action = 'alert',
  $service = '',
  $start = '',
  $stop = '',
  $restarts = undef,
  $cycles = undef,
  $restart_action = 'timeout',
) {

  include monit
  $include_dir = $monit::include_dir
  $service_bin = $monit::service_bin
  $real_file = $file ? {
    ''      => $name,
    default => $file,
  }

  $real_start   = $start ? {
    ''      => "${service_bin} ${service} start",
    default => $start,
  }
  $real_stop    = $stop ? {
    ''      => "${service_bin} ${service} stop",
    default => $stop,
  }

  file { "${include_dir}/${name}_file.monitrc":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('monit/file.erb'),
    notify  => Class['monit::service'],
    require => Class['monit::install'],
  }

}
