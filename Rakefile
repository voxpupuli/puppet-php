require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'

PuppetLint.configuration.fail_on_warnings
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.send('disable_class_parameter_defaults')
PuppetLint.configuration.relative = true

task :default => [:spec, :lint]

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
