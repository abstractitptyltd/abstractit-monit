# define monit::alert

define monit::alert (
  $ensure = present,
  $email = undef,
  $condition = undef,
  $events = undef,
  $reminder = undef,
) {
  include monit
  $include_dir = $monit::include_dir
  $service_bin = $monit::service_bin
  
  $real_ensure = $ensure ? {
    absent => absent,
    default => file,
  }
  
  file { "${include_dir}/${name}_alert.monitrc":
    ensure  => $real_ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('monit/alert.erb'),
    notify  => Class['monit::service'],
    require => Class['monit::install'],
  }
}
