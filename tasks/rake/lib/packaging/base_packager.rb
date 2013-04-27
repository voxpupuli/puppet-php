gem 'fpm', '<=0.3.11'
require 'fpm'
require 'fpm/program'
require 'pp'

$:.unshift(File.join(File.dirname(__FILE__), '..'))
require 'version_helper'

class BasePackager

  def initialize(package_type)
    self.validate_environment

    version_helper = VersionHelper.new

    @basedirectory = ENV['WORKSPACE']
		@semver_version = version_helper.semver_version
		@release = "1"
    @package_type = package_type 
    
    case package_type
    when "rpm"
      @first_delimiter, @second_delimiter, @architecture = "-", ".", "noarch"
    when "deb"
      @first_delimiter, @second_delimiter, @architecture = "_", "_", "all"
    end
  end

  def validate_environment()
    if ENV['WORKSPACE'].nil?
      fail("Environment variable WORKSPACE has not been set.")
    end
		if ENV['BUILD_NUMBER'].nil?
      ENV["BUILD_NUMBER"] = "0"
    end
    if ENV['GIT_COMMIT'].nil?
      ENV['GIT_COMMIT'] = "54b0c58c7ce9f2a8b551351102ee0938"[0,10]
    end
  end
 
  def build(module_name)
		ENV["#{ENV['JOB_NAME']}_semver_version"] = @semver_version
    package_name = "cegeka-puppet-#{module_name}"
    destination_file = "#{package_name}#{@first_delimiter}#{@semver_version}-#{@release}#{@second_delimiter}#{@architecture}.#{@package_type}"
    destination_folder = "#{@basedirectory}/#{module_name}/#{RESULTS}/dist"
    url = "https://github.com/cegeka/puppet-#{module_name}"
    description = "Puppet module: #{module_name} by Cegeka\nModule #{module_name} description goes here."

    static_arguments = ["-t", @package_type, "-s", "dir", "-a", @architecture, "-m", "Cegeka <computing@cegeka.be>", "--prefix", "/etc/puppet/modules"]
		exclude_arguments = ["-x", ".git", "-x", ".gitignore", "-x", "tasks", "-x", "Rakefile", "-x", "target", "-x", ".project", "-x", ".puppet-lintrc"]
    var_arguments = ["-n", package_name, "-v", @semver_version, "--iteration", @release, "--url", url, "--description", description, "-C", @basedirectory, module_name]
    arguments = static_arguments + exclude_arguments + var_arguments
    
    tmpdir = Dir.mktmpdir
    Dir.chdir tmpdir
    FileUtils.mkpath destination_folder
    packagebuild = FPM::Program.new
    ret = packagebuild.run(arguments)
    FileUtils.mv("#{tmpdir}/#{destination_file}","#{destination_folder}/#{destination_file}")
    FileUtils.remove_entry_secure(tmpdir)
    return "Created #{destination_folder}/#{destination_file}"
  end

end
