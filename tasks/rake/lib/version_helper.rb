require File.expand_path('../../../env', __FILE__)

class VersionHelper

	def initialize()
		filename = File.join(MODULE_ROOT_DIR, 'Modulefile')
		@module_file = File.read(filename)
	end

	def semver_version
		if ENV['GIT_COMMIT'].nil?
    	ENV['GIT_COMMIT'] = "54b0c58c7ce9f2a8b551351102ee0938"[0,10]
    end

		return package_version + "+build." + ENV['BUILD_NUMBER'] + "." + ENV['GIT_COMMIT'][0,10]
	end

	private	
	def package_version
    @module_file.each_line do |line|
      if line.match(/version/)
        return line.split(' ')[1].gsub("'", "")
      end
    end
  end

end
