# Define: monit::file
#
# setup a file for monit to monitor
#

define monit::file (
  $path,
  $file,
  $age,
  $increment = 'minutes',
  $action = 'alert',
) {

  include monit
  $include_dir = $monit::include_dir

  file { "${include_dir}/${name}.monitrc":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('monit/file.erb'),
    notify  => Class['monit::service'],
    require => Class['monit::install'],
  }

}
