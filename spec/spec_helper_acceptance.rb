require 'beaker-rspec'
require 'pry'

hosts.each do |host|
   on host, "mkdir -p #{host['distmoduledir']}"
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do

    hosts.each do |host|
      on host, 'test -x /usr/bin/zypper' do |result|
        if result.exit_code == 0
          on host, 'zypper addrepo -f --no-gpgcheck http://demeter.uni-regensburg.de/SLES11SP3-x64/DVD1/ "SLES11SP3-x64 DVD1 Online"'
          on host, 'zypper addrepo -f --no-gpgcheck http://demeter.uni-regensburg.de/SLE11SP3-SDK-x64/DVD1/ "SUSE-Linux-Enterprise-Software-Development-Kit-11-SP3"'
          on host, 'zypper addrepo -f --no-gpgcheck http://download.opensuse.org/repositories/systemsmanagement:/puppet/SLE_11_SP3/ systemsmanagement-puppet'
          on host, 'zypper in -y --force-resolution puppet'
        end
      end
    end

    # Install module
    puppet_module_install(:source => proj_root, :module_name => 'php')
    hosts.each do |host|
      on host, puppet('module','install','puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module','install','puppetlabs-apt'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module','install','puppetlabs-inifile'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module','install','darin-zypprepo'), { :acceptable_exit_codes => [0,1] }
    end
  end
end
