# Define: monit::ping
#
# add a ping check  to a host for monit to monitor
#

define monit::ping (
  $address = $title,
  $groups = [],
  $check_type = 'ping',
  $count = undef,
  $timeout = undef,
  $action = 'alert',
  $service = undef,
  $start = undef,
  $stop = undef,
  $restarts = undef,
  $cycles = undef,
  $restart_action = 'alert',
) {
  include monit
  $include_dir = $monit::include_dir
  $service_bin = $monit::service_bin

  $real_start   = $start ? {
    ''      => "${service_bin} ${service} start",
    default => $start,
  }
  $real_stop    = $stop ? {
    ''      => "${service_bin} ${service} stop",
    default => $stop,
  }

  file { "${include_dir}/${name}_ping.monitrc":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('monit/ping.erb'),
    notify  => Class['monit::service'],
    require => Class['monit::install'],
  }

}
