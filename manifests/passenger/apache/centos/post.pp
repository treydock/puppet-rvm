class rvm::passenger::apache::centos::post(
  $ruby_version,
  $version,
  $rvm_prefix = '/usr/local/',
  $mininstances = '1',
  $maxpoolsize = '6',
  $poolidletime = '300',
  $maxinstancesperapp = '0',
  $spawnmethod = 'smart-lv2',
  $gempath,
  $binpath
) {

  $ruby_wrapper_path    = "${rvm_prefix}rvm/wrappers/${ruby_version}/ruby"

  if versioncmp($version, '4.0.0') >= 0 {
    $mod_passenger_path = "${rvm::passenger::apache::gempath}/passenger-${rvm::passenger::apache::version}/libout/apache2/mod_passenger.so"
    $passenger_ruby     = "PassengerDefaultRuby ${ruby_wrapper_path}"
  } else {
    $mod_passenger_path = "${rvm::passenger::apache::gempath}/passenger-${rvm::passenger::apache::version}/ext/apache2/mod_passenger.so"
    $passenger_ruby     = "PassengerRuby ${ruby_wrapper_path}"
  }

  exec {
    'passenger-install-apache2-module':
      command   => "${rvm::passenger::apache::binpath}rvm ${rvm::passenger::apache::ruby_version} exec passenger-install-apache2-module -a",
      creates   => $mod_passenger_path,
      logoutput => 'on_failure',
      require   => [Rvm_gem['passenger'], Package['httpd','httpd-devel','mod_ssl']];
  }

  file {
    '/etc/httpd/conf.d/passenger.conf':
      ensure  => file,
      content => template('rvm/passenger-apache-centos.conf.erb'),
      require => Exec['passenger-install-apache2-module'];
  }
}
