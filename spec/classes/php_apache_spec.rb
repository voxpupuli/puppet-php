require 'spec_helper'

describe 'php::apache', :type => :class do
  let(:facts) { { :osfamily => 'Debian',
                  :lsbdistid => 'Debian',
                  :path     => '/usr/local/bin:/usr/bin:/bin' } }

  describe 'when called with no parameters on Debian' do
    it {
      should contain_package('libapache2-mod-php5').with({
        'ensure'  => 'installed',
      })
    }
  end
  describe 'when called with no parameters on Suse' do
    let(:facts) { { :osfamily => 'Suse',
                    :path     => '/usr/local/bin:/usr/bin:/bin' } }
    it {
      should contain_package('apache2-mod_php5').with({
        'ensure'  => 'installed',
      })
    }
  end
end
