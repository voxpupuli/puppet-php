# frozen_string_literal: true

require 'spec_helper'

describe 'php::repo::debian', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      before do
        Puppet::Parser::Functions.newfunction(:my_assert_private, type: :rvalue) do |args|
          # Fake assert_private function from stdlib to not fail within this test
        end
      end

      describe 'works without params' do
        let(:pre_condition) do
          'function assert_private() { return my_assert_private() }'
        end

        if facts[:os]['name'] == 'Debian'
          it { is_expected.to compile.with_all_deps }

          case facts[:os]['release']['major']
          when '6', '7', '8'
            it { is_expected.to contain_apt__source('source_php_dotdeb') }
            it { is_expected.not_to contain_apt__source('source_php_sury') }
          when '9', '10', '11'
            it { is_expected.not_to contain_apt__source('source_php_dotdeb') }
            it { is_expected.to contain_apt__source('source_php_sury') }
          end
        else
          it { is_expected.to compile.and_raise_error(%r{class php::repo::debian does not work on OS}) }
        end
      end
    end
  end
end
