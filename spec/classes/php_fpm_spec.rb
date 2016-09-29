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
          let(:params) do
            {
                package: 'php5-fpm',
                ensure: 'latest'
            }
          end
          it { is_expected.to contain_package('php5-fpm').with_ensure('latest') }
          it { is_expected.to contain_service('php5-fpm').with_ensure('running') }
        else
          it { is_expected.to contain_service('php-fpm').with_ensure('running') }
        end
      end
    end
  end
end
