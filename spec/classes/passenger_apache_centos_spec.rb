require 'spec_helper'

describe 'rvm::passenger::apache' do

  # assume RVM is already installed
  let(:facts) {{ :rvm_version => '1.10.0', :operatingsystem => 'CentOS' }}

  let :default_params do
    {
      :rvm_prefix         => '/usr/local/',
      :mininstances       => '1',
      :maxpoolsize        => '6',
      :poolidletime       => '300',
      :maxinstancesperapp => '0',
      :spawnmethod        => 'smart-lv2',
    }
  end

  context "ruby_version => ruby-1.9.3-p429, version => 3.0.19" do
    let :params do
      default_params.merge({
        :ruby_version => 'ruby-1.9.3-p429',
        :version => '3.0.19',
      })
    end
    let(:gempath) { "#{params[:rvm_prefix]}rvm/gems/#{params[:ruby_version]}/gems" }
    let(:binpath) { "#{params[:rvm_prefix]}rvm/bin/" }

    include_context 'rvm::passenger::apache::centos::post'
  end

  context "ruby_version => ruby-1.9.3-p429, version => 4.0.5" do
    let :params do
      default_params.merge({
        :ruby_version => 'ruby-1.9.3-p429',
        :version => '4.0.5',
      })
    end
    let(:gempath) { "#{params[:rvm_prefix]}rvm/gems/#{params[:ruby_version]}/gems" }
    let(:binpath) { "#{params[:rvm_prefix]}rvm/bin/" }
    
    include_context 'rvm::passenger::apache::centos::post'
  end
end
