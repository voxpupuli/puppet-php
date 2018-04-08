require 'spec_helper'

describe 'php::repo::debian', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      case facts[:osfamily]
      when 'debian'
        describe 'when called with no parameters on Debian' do
          it { is_expected.to contain_apt__source('php') }
        end
        describe 'when called with include_src on Debian' do
          let(:params) do
            {
              include_src: true
            }
          end

          it do
            is_expected.to contain_apt__source('php').with(
              include: {
                src: true
              }
            )
          end
        end
      end
    end
  end
end
