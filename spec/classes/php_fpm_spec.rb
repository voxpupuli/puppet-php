require 'spec_helper'

describe 'php::fpm', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end
      describe 'when called with no parameters' do
        case facts[:osfamily]
        when 'Debian'
          case facts[:operatingsystem]
          when 'Ubuntu'
            let(:params) { { package: 'php5.6-fpm', ensure: 'latest' } }
            it { is_expected.to contain_package('php5.6-fpm').with_ensure('latest') }
            it { is_expected.to contain_service('php5.6-fpm').with_ensure('running') }
          when 'Debian'
            let(:params) { { package: 'php5-fpm', ensure: 'latest' } }
            it { is_expected.to contain_package('php5-fpm').with_ensure('latest') }
            it { is_expected.to contain_service('php5-fpm').with_ensure('running') }
          end
        else
          it { is_expected.to contain_service('php-fpm').with_ensure('running') }
        end
      end
    end
  end
end
