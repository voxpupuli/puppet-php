require 'rubygems'
require 'rake'

task_dir = File.expand_path("../tasks", __FILE__)

FileList["#{task_dir}/**/*.rake"].each { |fn| load fn }

desc "Default task prints the available targets."
task :default do
  sh %{rake -T}
end
