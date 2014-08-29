require 'spec_helper'

describe 'php::fpm', :type => :class do
  let(:facts) { { :path => '/usr/local/bin:/usr/bin:/bin' } }

  describe 'when called with no parameters on Debian' do
    let(:facts) { { :osfamily  => 'Debian' } }
    let(:params) { { :ensure => 'latest' } }

    it {
      should contain_package('php5-fpm').with({
        'ensure' => 'latest',
      })
      should contain_service('php5-fpm').with({
        'ensure' => 'running',
      })
    }
  end

  describe 'when called with no parameters on Suse' do
    let(:facts) { { :osfamily => 'Suse' } }

    it {
      should contain_service('php-fpm').with({
        'ensure' => 'running',
      })
    }
  end
end
