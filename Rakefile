require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'

Rake::Task['lint'].clear

PuppetLint::RakeTask.new :lint do |config|
  config.pattern = 'manifests/**/*.pp'
  config.fail_on_warnings = true
end

PuppetLint.configuration.relative = true
PuppetLint.configuration.send('disable_class_inherits_from_params_class')

task :default => [:metadata, :lint, :spec]

task :metadata do
  sh 'metadata-json-lint metadata.json'
end

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
