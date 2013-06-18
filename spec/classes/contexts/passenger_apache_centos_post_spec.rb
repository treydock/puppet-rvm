require 'spec_helper'

shared_context 'rvm::passenger::apache::centos::post' do
  let :mod_passenger_path do
    if params[:version] >= '4.0.0'
      "#{gempath}/passenger-#{params[:version]}/libout/apache2/mod_passenger.so"
    else
      "#{gempath}/passenger-#{params[:version]}/ext/apache2/mod_passenger.so"
    end
  end

  let :ruby_version do
    params[:ruby_version].split('@').first
  end

  let :passenger_ruby_line do
    if params[:version] >= '4.0.0'
      "PassengerDefaultRuby #{params[:rvm_prefix]}rvm/wrappers/#{ruby_version}/ruby"
    else
      "PassengerRuby #{params[:rvm_prefix]}rvm/wrappers/#{ruby_version}/ruby"
    end
  end

  it do
    should contain_exec('passenger-install-apache2-module').with({
      'command'   => "#{binpath}rvm #{params[:ruby_version]} exec passenger-install-apache2-module -a",
      'creates'   => mod_passenger_path,
      'logoutput' => 'on_failure',
      'require'   => ['Rvm_gem[passenger]', 'Package[httpd]', 'Package[httpd-devel]', 'Package[mod_ssl]'],
    })
  end

  it do
    should contain_file('/etc/httpd/conf.d/passenger.conf').with({
      'ensure'  => 'present',
      'require' => 'Exec[passenger-install-apache2-module]',
    }) \
    .with_content(/^LoadModule passenger_module #{mod_passenger_path}$/) \
    .with_content(/^\s+PassengerRoot #{gempath}\/passenger-#{params[:version]}$/) \
    .with_content(/^\s+#{passenger_ruby_line}$/)
  end
end
