require 'spec_helper'

describe 'rvm::passenger::gem' do

  # assume RVM is already installed
  let(:facts) {{ :rvm_version => '1.10.0', :operatingsystem => 'CentOS' }}

  context "ruby_version => ruby-1.9.3-p429, version => 3.0.19" do
    let(:params) {{ :ruby_version => 'ruby-1.9.3-p429', :version => '3.0.19'}}
    it do
      should contain_rvm_gem('passenger').with({
        'ensure'        => params[:version],
        'ruby_version'  => params[:ruby_version],
        'require'       => "Rvm_system_ruby[#{params[:ruby_version]}]",
      })
    end
  end

  context "ruby_version => ruby-1.9.3-p429@global, version => 3.0.19" do
    let(:params) {{ :ruby_version => 'ruby-1.9.3-p429@global', :version => '3.0.19'}}
    it do
      should contain_rvm_gem('passenger').with({
        'ensure'        => params[:version],
        'ruby_version'  => params[:ruby_version],
        'require'       => "Rvm_gemset[#{params[:ruby_version]}]",
      })
    end
  end
end
