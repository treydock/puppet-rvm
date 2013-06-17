class rvm::passenger::gem($ruby_version, $version) {

  if size(split($ruby_version, '@')) > 1 {
    $rvm_gem_require = Rvm_gemset[$ruby_version]
  } else {
    $rvm_gem_require = Rvm_system_ruby[$ruby_version]
  }

  rvm_gem { 'passenger':
    ensure        => $version,
    ruby_version  => $ruby_version,
    require       => $rvm_gem_require,
  }
}
