source 'https://rubygems.org'

#group :rake do
#  gem 'puppet-blacksmith', '>=1.0.5'
#end

group :development, :test do
  gem 'rake'
  gem 'puppetlabs_spec_helper', :require => false
  gem 'puppet-lint', '~> 0.3.2'
  gem 'travis-lint'
  gem 'rspec-system-puppet', '~>2.0.0'
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end
