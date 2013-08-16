require 'rubygems'
require 'rake'
require 'puppet-lint/tasks/puppet-lint'

task_dir = File.expand_path("../tasks", __FILE__)

PuppetLint.configuration.send('disable_class_inherits_from_params_class')

FileList["#{task_dir}/**/*.rake"].each { |fn| load fn }

desc "Default task prints the available targets."
task :default do
  sh %{rake -T}
end
