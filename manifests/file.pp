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
  file { "/etc/monit/conf.d/${name}.monitrc":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('monit/file.erb'),
  }

}