# frozen_string_literal: true

require 'spec_helper'

describe 'php::repo', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      let :pre_condition do
        'include php'
      end

      describe 'works without params' do
        if facts[:os]['name'] == 'Archlinux'
          it { is_expected.to compile.and_raise_error(%r{No repo available for}) }
        else
          it { is_expected.to compile.with_all_deps }
        end
      end

      describe 'when configuring a package repo' do
        case facts[:os]['family']
        when 'Debian'
          case facts[:os]['name']
          when 'Debian'
            it { is_expected.to contain_class('php::repo::debian') }
          when 'Ubuntu'
            it { is_expected.to contain_class('php::repo::ubuntu') }
          end
        when 'Suse'
          it { is_expected.to contain_class('php::repo::suse') }
        when 'RedHat'
          it { is_expected.to contain_class('php::repo::redhat') }
        end
      end
    end
  end
end
