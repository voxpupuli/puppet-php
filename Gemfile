source 'https://rubygems.org'

group :development, :test do
  gem 'rake'
  gem 'rspec'
  gem 'rspec-puppet'
  gem 'puppetlabs_spec_helper'
  gem 'puppet-module'
  gem 'beaker', :github => 'Mayflower/beaker', :branch => 'master'
  gem 'beaker-rspec'
  gem 'pry'
  gem 'yard'
  gem 'puppet-lint'
  gem 'puppet-lint-unquoted_string-check'
  gem 'puppet-lint-empty_string-check'
  gem 'puppet-lint-variable_contains_upcase'
  gem 'puppet-lint-absolute_classname-check'
  gem 'puppet-lint-undef_in_function-check'
  gem 'puppet-lint-leading_zero-check'
  gem 'puppet-lint-trailing_comma-check'
  gem 'puppet-lint-file_ensure-check'
  gem 'metadata-json-lint'
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
