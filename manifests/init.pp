# == Class: monit
#
# Manages installing and configuring monit and setting up services, processes, programs and files to monitor.
#
# === Parameters
#
# [*ensure*]
#   ensure paramater for the monit service
#   Default: 'running' ( set to 'stopped' to stop the monit process )
#
# [*enable*]
#   enable paramater for the monit service.
#   enables the service at boot.
#   Default: true
#
# [*ensure*]
#   ensure paramater for the monit service
#   Default: 'running' ( set to 'stopped' to stop the monit process )
#
# [*from_email*]
#   from address for alert emails
#   Default: '' ( set to a valid email address to send emails )
#
# [*alert_email*]
#   email address alert emails will be sent to
#   Default: '' ( set to a valid email address to send emails )
#
# [*mailserver*]
#   mailserver to send emails through
#   Default: '' ( set to a valid smtp server to send emails )
#
# [*check_local*]
#   whether to check local defaults like disk and such
#   Default: true ( set to false disable )
#
# [*version*]
#   version of packages to install
#   Default: installed ( set to a valid version for the package type to install )
#
# === Examples
#
#  class { 'monit':
#    from_email => 'monit@domain.com',
#    alert_email => 'alerts@domain.com',
#    from_email => 'mail.domain.com',
#  }
#
# === Authors
#
# Pete Brown <pete@abstractit.com.au>
#
# === Copyright
#
# Copyright 2014 Pete Brown, unless otherwise noted.
#

class monit (
  $version          = 'installed',
  $ensure           = 'running',
  $enable           = true,
  $check_interval   = '120',
  $start_delay      = '',
  $from_email       = '',
  $alert_subject    = '',
  $alert_body       = '',
  $alert_email      = '',
  $alert_reply_to   = '',
  $mailserver       = '',
  $eventqueue       = false,
  $eventslots       = '100',
  $mmonit_collector = '',
  $status_server    = true,
  $status_port      = '2812',
  $status_address   = 'localhost',
  $status_allow     = ['localhost'],
  $check_local      = true,
  $check_load       = true,
  $load_threshold   = {
    '1min' => '20',
    '5min' => '10'
  }
  ,
  $check_cpu        = true,
  $cpu_threshold    = {
    'user'   => '90%',
    'system' => '80%',
    'wait'   => '70%'
  }
  ,
  $check_memory     = true,
  $memory_threshold = '75%',
  $check_swap       = $monit::params::check_swap,
  $swap_threshold   = '25%',
  $check_disk       = true,
  $disk_usage       = '80%',
  $logfacility      = 'file',
  $log_file         = $monit::params::log_file,
  $include_dir      = $monit::params::include_dir,
  $service_bin      = $monit::params::service_bin,
  $include_purge    = false,) inherits monit::params {
  class { 'monit::install':
    version => $version,
  } ->
  class { 'monit::config':
    check_interval   => $check_interval,
    start_delay      => $start_delay,
    from_email       => $from_email,
    alert_email      => $alert_email,
    mailserver       => $mailserver,
    check_local      => $check_local,
    check_load       => $check_load,
    load_threshold   => $load_threshold,
    check_cpu        => $check_cpu,
    cpu_threshold    => $cpu_threshold,
    check_memory     => $check_memory,
    memory_threshold => $memory_threshold,
    check_swap       => $check_swap,
    swap_threshold   => $swap_threshold,
    check_disk       => $check_disk,
    disk_usage       => $disk_usage,
    logfacility      => $logfacility,
    log_file         => $log_file,
    include_dir      => $include_dir,
    include_purge    => $include_purge
  } ~>
  class { 'monit::service':
    ensure => $ensure,
    enable => $enable,
  } ->
  Class['monit']

}
