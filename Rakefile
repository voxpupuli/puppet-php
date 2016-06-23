require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'

Rake::Task['lint'].clear

PuppetLint::RakeTask.new :lint do |config|
  config.pattern = 'manifests/**/*.pp'
  config.fail_on_warnings = true
end

task :default => [:validate, :lint, :spec]