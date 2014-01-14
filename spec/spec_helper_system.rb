#   Copyright 2013 Brainsware
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

require 'rspec-system/spec_helper'
require 'rspec-system-puppet/helpers'
require 'rspec-system-serverspec/helpers'
include Serverspec::Helper::RSpecSystem
include Serverspec::Helper::DetectOS
include RSpecSystemPuppet::Helpers

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Enable colour
  c.tty = true

  c.include RSpecSystemPuppet::Helpers

  # This is where we 'setup' the nodes before running our tests
  c.before :suite do
    # Install puppet
    puppet_install

    # Install modules
    puppet_module_install(:source => proj_root, :module_name => 'php')

    # ... and its dependencies
    # We only want one source of truth for deps, so we read the Modulefile:
    File.open(File.join(proj_root, 'Modulefile')).each do |line|
      if line =~ /^\bdependency\b/
        m =  line.split("'")[1]
        cmd = "puppet module install #{m}"
        cmd += " --version #{line.split(/\s+/)[3].chop}" if line.split(/\s+/)[3]
        shell(cmd)
      end
    end
  end

end

