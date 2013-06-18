class rvm::passenger::apache::centos::post(
  $ruby_version,
  $version,
  $rvm_prefix = '/usr/local/',
  $mininstances = '1',
  $maxpoolsize = '6',
  $poolidletime = '300',
  $maxinstancesperapp = '0',
  $spawnmethod = 'smart-lv2',
  $gempath            = $rvm::passenger::apache::gempath,
  $binpath            = $rvm::passenger::apache::binpath
) inherits rvm::passenger::apache {

  $ruby_version_real    = inline_template('<%= @ruby_version.split("@").first %>')
  $ruby_wrapper_path    = "${rvm_prefix}rvm/wrappers/${ruby_version_real}/ruby"

  if versioncmp($version, '4.0.0') >= 0 {
    $mod_passenger_path = "${gempath}/passenger-${version}/libout/apache2/mod_passenger.so"
    $passenger_ruby     = "PassengerDefaultRuby ${ruby_wrapper_path}"
  } else {
    $mod_passenger_path = "${gempath}/passenger-${version}/ext/apache2/mod_passenger.so"
    $passenger_ruby     = "PassengerRuby ${ruby_wrapper_path}"
  }

  exec { 'passenger-install-apache2-module':
    command   => "${binpath}rvm ${ruby_version} exec passenger-install-apache2-module -a",
    creates   => $mod_passenger_path,
    logoutput => 'on_failure',
    require   => [Rvm_gem['passenger'], Package['httpd','httpd-devel','mod_ssl']],
  }

  file { '/etc/httpd/conf.d/passenger.conf':
    ensure  => present,
    content => template('rvm/passenger-apache-centos.conf.erb'),
    require => Exec['passenger-install-apache2-module'],
  }
}
