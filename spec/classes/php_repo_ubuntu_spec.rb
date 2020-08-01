require 'spec_helper'

describe 'php::repo::ubuntu', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      describe 'works without params' do
        if facts[:os]['name'] == 'Ubuntu'
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_apt__ppa('ppa:ondrej/php') }
        else
          it { is_expected.to compile.and_raise_error(%r{class php::repo::ubuntu does not work on OS}) }
        end
      end
    end
  end
end
