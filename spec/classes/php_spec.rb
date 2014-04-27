require 'spec_helper'

describe 'php', :type => :class do
  let(:facts) { { :osfamily => 'Debian',
                  :path     => '/usr/local/bin:/usr/bin:/bin' } }

  describe 'when called with no parameters on Debian' do
    it {
      should contain_package('php5-cli').with({
        'ensure' => 'installed',
      })
      should contain_class('php::fpm')
      should contain_package('php5-dev').with({
        'ensure' => 'installed',
      })
      should contain_package('php-pear').with({
        'ensure' => 'installed',
      })
      should contain_class('php::composer')
      should_not contain_package('libapache2-mod-php5')
    }
  end

  describe 'when called with no parameters on Suse' do
    let(:facts) { { :osfamily => 'Suse',
                    :path     => '/usr/local/bin:/usr/bin:/bin' } }
    it {
      should contain_package('php5').with({
        'ensure' => 'installed',
      })
      should contain_package('php5-devel').with({
        'ensure' => 'installed',
      })
      should contain_package('php5-pear').with({
        'ensure' => 'installed',
      })
      should_not contain_package('php5-cli')
      should_not contain_package('php5-dev')
      should_not contain_package('php-pear')
    }
  end

  describe 'when apache is enabled' do
    let(:params) { { :apache => true, } }
    it {
      should contain_class('php::apache')
    }
  end
  describe 'when fpm is disabled' do
    let(:params) { { :fpm => false, } }
    it {
      should_not contain_class('php::fpm')
    }
  end
  describe 'when composer is disabled' do
    let(:params) { { :composer => false, } }
    it {
      should_not contain_class('php::composer')
    }
  end
end
