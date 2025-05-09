# frozen_string_literal: true

require 'spec_helper'

describe 'php::composer', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      let :pre_condition do
        'class { "php": composer => false }'
      end

      describe 'works without params' do
        it { is_expected.to compile.with_all_deps }
      end

      describe 'when called with no parameters' do
        it { is_expected.to contain_class('php::composer::auto_update') }
        it { is_expected.to contain_archive('download composer') }
      end

      describe 'when auto_update is disabled' do
        let(:params) { { auto_update: false } }

        it { is_expected.not_to contain_class('php::composer::auto_update') }
      end

      describe 'when called with proxy_server parameters' do
        let(:params) { { proxy_server: 'http://example.com' } }

        it { is_expected.to contain_archive('download composer').with(proxy_server: 'http://example.com') }
        it { is_expected.to contain_exec('update composer').with(environment: ['HOME=/root', 'http_proxy=http://example.com', 'https_proxy=http://example.com']) }
      end

      describe 'when called with proxy_server and proxy_type parameters' do
        let(:params) { { proxy_server: 'example.com', proxy_type: 'http' } }

        it { is_expected.to contain_archive('download composer').with(proxy_server: 'example.com') }
        it { is_expected.to contain_archive('download composer').with(proxy_type: 'http') }
        it { is_expected.to contain_exec('update composer').with(environment: ['HOME=/root', 'http_proxy=http://example.com', 'https_proxy=http://example.com']) }
      end

      describe 'when called with proxy_server without proxy_type parameters' do
        let(:params) { { proxy_server: 'example.com' } }

        it { is_expected.to compile.and_raise_error(%r{proxy_type must be defined if proxy_server is not full URL \(https://example.com\)}) }
      end
    end
  end
end
