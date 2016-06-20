require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'

Rake::Task['lint'].clear

PuppetLint::RakeTask.new :lint do |config|
  config.pattern = 'manifests/**/*.pp'
  config.fail_on_warnings = true
end

task :default => [:validate, :lint, :spec]

namespace :spec do
  task :acceptance do
    ['centos65', 'debian7', 'sles11sp3', 'ubuntu1404'].each do |set|
      name = 'spec:acceptance:' + set
      ENV['BEAKER_set'] = set
      ENV['BEAKER_destroy'] = 'onpass'
      Spec::Rake::SpecTask.new(name) do |t|
        t.pattern = 'spec/acceptance/**/*_spec.rb'
      end
      Rake::Task[name].invoke
    end
  end
end
