# Class: monit::config
#
# config file for monit
#

class monit::config (
  $check_interval,
  $start_delay,
  $from_email,
  $alert_email,
  $mailserver,
  $check_local,
  $check_load,
  $load_threshold,
  $check_cpu,
  $cpu_threshold,
  $check_memory,
  $memory_threshold,
  $check_swap,
  $swap_threshold,
  $check_disk,
  $disk_usage,
  $logfacility,
  $log_file,
  $include_dir,
  $include_purge,
  ) {
  include monit::params

  include monit
  $monit_conf_file = $monit::params::monit_conf_file

  $alert_ensure = $alert_email ? {
    ''      => absent,
    default => present,
  }
  
  monit::alert { 'main':
    ensure => $alert_ensure,
    email  => $alert_email,
  }

  file { $monit_conf_file:
    ensure  => file,
    content => template('monit/monitrc.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
  }

  file { $include_dir:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    purge   => $include_purge,
    recurse => $include_purge,
  }

  file { "${include_dir}/logging":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('monit/logging.erb'),
    require => File[$include_dir]
  }

}
