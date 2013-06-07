define rvm::system_user () {

  $username = $title
  $group = $::operatingsystem ? {
    default => 'rvm',
  }

  if ! defined(User[$username]) {
    user { $username:
      ensure => present;
    }
  }

  if ! defined(Group[$group]) {
    group { $group:
      ensure => present;
    }
  }

  exec { "/usr/sbin/usermod -a -G $group $username":
    unless  => "/usr/bin/getent group ${group} | /bin/egrep -q -E ':|,${username},|$'",
    require => [User[$username], Group[$group]];
  }
}
