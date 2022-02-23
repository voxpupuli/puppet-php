require 'spec_helper'

describe 'php::repo::debian', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      describe 'works without params' do
        if facts[:os]['name'] == 'Debian'
          it { is_expected.to compile.with_all_deps }
          context 'dotdeb' do
            let(:params) { { 'dotdeb' => true, 'sury' => false } }

            it { is_expected.to contain_apt__source('source_php_wheezy-php56') }
            it { is_expected.not_to contain_apt__source('source_php_sury') }
          end
          context 'sury' do
            let(:params) { { 'dotdeb' => false, 'sury' => true } }

            it { is_expected.not_to contain_apt__source('source_php_wheezy-php56') }
            it { is_expected.to contain_apt__source('source_php_sury') }
          end
        end
      end
    end
  end
end
