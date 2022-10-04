require 'spec_helper'

describe 'php::repo::redhat', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      case facts[:osfamily]
      when 'RedHat'
        describe 'when called with no parameters on RedHat' do
          it { is_expected.to contain_yumrepo('remi-php56') }
        end

        describe 'when called with version 7.0 on RedHat' do
          let(:params) do
            {
              version: '7.0'
            }
          end

          it { is_expected.to contain_yumrepo('remi-php70') }
        end

        describe 'when call with version 7.1 on RedHat' do
          let(:params) do
            {
              version: '7.1'
            }
          end

          it { is_expected.to contain_yumrepo('remi-php71') }
        end

        describe 'when call with version 7.2 on RedHat' do
          let(:params) do
            {
              version: '7.2'
            }
          end

          it { is_expected.to contain_yumrepo('remi-php72') }
        end

      end
    end
  end
end
