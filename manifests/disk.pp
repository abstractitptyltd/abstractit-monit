# define monit::disk

define monit::disk (
  $path = '',
  $disk_usage = '80%',
  $inode_usage = '80%',
  $checks = '5',
  $cycles = '15'
) {
  include monit
  $include_dir = $monit::include_dir
  $service_bin = $monit::service_bin
  
  $real_path = $path ? {
    '' => "/${name}",
    default => $path,
  }

  file { "${include_dir}/${name}_disk.monitrc":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('monit/disk.erb'),
    notify  => Class['monit::service'],
    require => Class['monit::install'],
  }

}