require File.expand_path('../../env', __FILE__)

$:.unshift(File.join(File.dirname(__FILE__), 'lib', 'packaging'))
require 'deb_packager'

desc "Create DEB package from puppet module."
task :deb do
  puts "Creating DEB package from puppet module..."
  module_name = ENV['JOB_NAME'].split('-')[1]
  
  deb_packager = DebPackager.new
  output = deb_packager.build(module_name)
  puts output
end
