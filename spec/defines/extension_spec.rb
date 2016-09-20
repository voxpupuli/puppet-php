require 'spec_helper'

describe 'php::extension' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end
      let(:pre_condition) { 'include php::params' }

      unless facts[:osfamily] == 'Suse' || facts[:osfamily] == 'FreeBSD' # FIXME: something is wrong on these
        etcdir = case facts[:osfamily]
                 when 'Debian'
                   case facts[:operatingsystem]
                   when 'Ubuntu'
                     '/etc/php/5.6/mods-available'
                   else
                     '/etc/php5/mods-available'
                   end
                 else
                   '/etc/php.d'
                 end

        context 'installation from repository' do
          let(:title) { 'json' }
          let(:params) do
            {
              package_prefix: 'php5-',
              settings: {
                'test' => 'foo'
              }
            }
          end

          it { is_expected.to contain_package('php5-json') }
          it do
            is_expected.to contain_php__config('json').with(
              file: "#{etcdir}/json.ini",
              config: {
                'test' => 'foo'
              }
            )
          end
        end

        context 'add settings prefix if requested' do
          let(:title) { 'json' }
          let(:params) do
            {
              name: 'json',
              settings_prefix: true,
              settings: {
                'test' => 'foo'
              }
            }
          end

          it { is_expected.to contain_php__config('json').with_config('json.test' => 'foo') }
        end

        context 'use specific settings prefix if requested' do
          let(:title) { 'json' }
          let(:params) do
            {
              name: 'json',
              settings_prefix: 'bar',
              settings: {
                'test' => 'foo'
              }
            }
          end

          it { is_expected.to contain_php__config('json').with_config('bar.test' => 'foo') }
        end

        context 'non-pecl extensions cannot be configured as zend' do
          let(:title) { 'xdebug' }
          let(:params) do
            {
              zend: true
            }
          end

          it { expect { is_expected.to raise_error(Puppet::Error) } }
        end

        context 'pecl extensions can be configured as zend' do
          let(:title) { 'xdebug' }
          let(:params) do
            {
              provider: 'pecl',
              zend: true
            }
          end

          it { is_expected.to contain_php__config('xdebug').with_config('zend_extension' => 'xdebug.so') }
        end

        context 'pecl extensions support so_name' do
          let(:title) { 'zendopcache' }
          let(:params) do
            {
              provider: 'pecl',
              zend: true,
              so_name: 'opcache'
            }
          end

          it do
            is_expected.to contain_php__config('zendopcache').with(
              file: "#{etcdir}/opcache.ini",
              config: {
                'zend_extension' => 'opcache.so'
              }
            )
          end
        end

        context 'pecl extensions support php_api_version' do
          let(:title) { 'xdebug' }
          let(:params) do
            {
              provider: 'pecl',
              zend: true,
              php_api_version: '20100525'
            }
          end

          it { is_expected.to contain_php__config('xdebug').with_config('zend_extension' => '/usr/lib/php5/20100525/xdebug.so') }
        end

        case facts[:osfamily]
        when 'Debian'
          context 'on Debian' do
            let(:title) { 'xdebug' }

            it { is_expected.to contain_php__config('xdebug').with_file("#{etcdir}/xdebug.ini") }
            context 'pecl installation' do
              let(:title) { 'json' }
              let(:params) do
                {
                  provider: 'pecl',
                  header_packages: ['libmemcached-dev'],
                  name: 'nice_name',
                  settings: {
                    'test' => 'foo'
                  }
                }
              end

              it { is_expected.to contain_package('pecl-json') }
              it { is_expected.to contain_package('libmemcached-dev') }
              it { is_expected.to contain_package('build-essential') }
              it do
                is_expected.to contain_php__config('json').with(
                  file: "#{etcdir}/json.ini",
                  config: {
                    'extension' => 'nice_name.so',
                    'test'      => 'foo'
                  }
                )
              end
            end
          end
        end
      end
    end
  end
end
