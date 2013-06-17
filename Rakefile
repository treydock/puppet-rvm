require 'rubygems'
require 'bundler/setup'

Bundler.require :default

require 'rspec/core/rake_task'
require 'puppetlabs_spec_helper/rake_tasks'
require 'rspec-system/rake_task'

task :default do
  sh %{rake -T}
end

namespace :spec do
  desc "Run rspec-puppet and puppet-lint tasks"
  task :all => [ :spec, :lint ]
end
