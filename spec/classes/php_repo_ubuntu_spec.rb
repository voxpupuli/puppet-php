# frozen_string_literal: true

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
          it { is_expected.to contain_apt__keyring('packages-sury-org.gpg') }
          it { is_expected.to contain_apt__source('source_php_sury') }
        else
          it { is_expected.to compile.and_raise_error(%r{class php::repo::ubuntu does not work on OS}) }
        end
      end

      describe 'fails when version is specified' do
        if facts[:os]['name'] == 'Ubuntu'
          let(:params) { { version: '8.1' } }

          it { is_expected.to compile.and_raise_error(%r{version parameter has been removed}) }
        end
      end
    end
  end
end
