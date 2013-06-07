require 'spec_helper'

describe 'rvm::system' do

  # assume RVM is already installed
  let(:facts) {{ :rvm_version => '1.10.0' }}

  let :system_rvm_command do
    "bash -c '/usr/bin/curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer -o /tmp/rvm-installer && \
chmod +x /tmp/rvm-installer && \
rvm_bin_path=/usr/local/rvm/bin rvm_man_path=/usr/local/rvm/man /tmp/rvm-installer #{actual_version} && \
rm /tmp/rvm-installer'"
  end

  context "default parameters" do
    let(:actual_version) { 'stable' }
    it { should_not contain_exec('system-rvm-get') }
    it { should contain_exec('system-rvm').with(:command => system_rvm_command) }
  end

  context "with present version" do
    let(:params) {{ :version => 'present' }}
    let(:actual_version) { 'stable' }
    it { should_not contain_exec('system-rvm-get') }
    it { should contain_exec('system-rvm').with(:command => system_rvm_command) }
  end

  context "with latest version" do
    let(:params) {{ :version => 'latest' }}
    let(:actual_version) { '--version latest' }
    it { should contain_exec('system-rvm-get').with_command('rvm get latest') }
    it { should contain_exec('system-rvm').with(:command => system_rvm_command) }
  end

  context "with explicit version" do
    let(:params) {{ :version => '1.20.0' }}
    let(:actual_version) { '--version 1.20.0' }
    it { should contain_exec('system-rvm-get').with_command('rvm get 1.20.0') }
    it { should contain_exec('system-rvm').with(:command => system_rvm_command) }
  end
end
