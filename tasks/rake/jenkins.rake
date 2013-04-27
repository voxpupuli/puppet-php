require File.expand_path('../../env', __FILE__)

$:.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'version_helper'

namespace "jenkins" do
  begin
    require 'ci/reporter/rake/rspec'
    require 'ci/reporter/rake/cucumber'
  rescue LoadError
    fail 'Cannot load ci_reporter, did you install it?'
  end
  
  SPEC_REPORTS_PATH = "#{RESULTS}/reports/spec/"
  ACCEPTANCE_REPORTS_PATH = "#{RESULTS}/reports/acceptance/"

  desc "Run Jenkins compatible Rspec tests."
  task :spec_tests => ["ci:setup:rspec"] do
    ENV['CI_REPORTS'] = SPEC_REPORTS_PATH
    FileUtils.mkdir_p(SPEC_REPORTS_PATH)
    
    Rake::Task[:spec].invoke
  end

  desc "Run Jenkins compatible acceptance tests."
  task :acceptance_tests => ["ci:setup:cucumber"] do
    ENV['CI_REPORTS'] = ACCEPTANCE_REPORTS_PATH
    FileUtils.mkdir_p(ACCEPTANCE_REPORTS_PATH)
    
    Rake::Task[:acceptance].invoke
  end

  desc "Archive job configuration in YAML format."
  task :archive_job_configuration do
    dist_dir = "#{RESULTS}/dist"

    module_name = ENV['JOB_NAME']
    git_commit = ENV['GIT_COMMIT']
		semver_version = VersionHelper.new.semver_version
    
    if !git_commit.nil? and !git_commit.empty?
      puts "Saving #{module_name}.yaml file"
      FileUtils.mkdir_p(dist_dir)
      open("#{dist_dir}/#{module_name}.yaml", "w") { |file|
        file.puts "module_name: #{module_name}"
        file.puts "git_commit: #{git_commit}"
				file.puts "semver_version: #{semver_version}"
      }
    end
  end
end
