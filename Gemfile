source 'https://rubygems.org'

group :development, :test do
  gem 'rake'
  gem 'rspec'
  gem 'rspec-puppet'
  gem 'puppetlabs_spec_helper'
  gem 'puppet-lint'
  gem 'puppet-module'
  gem 'beaker', :github => 'Mayflower/beaker', :branch => 'master'
  gem 'beaker-rspec'
  gem 'pry'
  gem 'yard'
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion
else
  gem 'facter'
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion
else
  gem 'puppet'
end

# vim:ft=ruby
