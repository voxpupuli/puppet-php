require 'spec_helper'

describe 'php', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      describe 'when called with no parameters' do
        case facts[:osfamily]
        when 'Suse', 'RedHat', 'CentOS'
          it { is_expected.to contain_class('php::global') }
        end

        case facts[:osfamily]
        when 'Debian'
          it { is_expected.not_to contain_class('php::global') }
          it { is_expected.to contain_class('php::fpm') }
          it { is_expected.to contain_package('php-pear').with_ensure('present') }
          it { is_expected.to contain_class('php::composer') }
          case facts[:os]['release']['major']
          when '14.04'
            it { is_expected.to contain_package('php5-cli').with_ensure('present') }
            it { is_expected.to contain_package('php5-fpm').with_ensure('present') }
            it { is_expected.to contain_package('php5-dev').with_ensure('present') }
          when '16.04'
            it { is_expected.to contain_package('php7.0-cli').with_ensure('present') }
            it { is_expected.to contain_package('php7.0-fpm').with_ensure('present') }
            it { is_expected.to contain_package('php7.0-dev').with_ensure('present') }
          end
        when 'Suse'
          it { is_expected.to contain_package('php5').with_ensure('present') }
          it { is_expected.to contain_package('php5-devel').with_ensure('present') }
          it { is_expected.to contain_package('php5-pear').with_ensure('present') }
          it { is_expected.not_to contain_package('php5-cli') }
          it { is_expected.not_to contain_package('php5-dev') }
          it { is_expected.not_to contain_package('php-pear') }
        when 'RedHat', 'CentOS'
          it { is_expected.to contain_package('php-cli').with_ensure('present') }
          it { is_expected.to contain_package('php-common').with_ensure('present') }
        end
      end

      describe 'when called with package_prefix parameter' do
        package_prefix = 'myphp-'
        let(:params) { { package_prefix: package_prefix } }

        case facts[:osfamily]
        when 'Suse', 'RedHat', 'CentOS'
          it { is_expected.to contain_class('php::global') }
        end

        case facts[:osfamily]
        when 'Debian', 'RedHat', 'CentOS'
          it { is_expected.to contain_package("#{package_prefix}cli").with_ensure('present') }
        end

        case facts[:osfamily]
        when 'Debian'
          it { is_expected.not_to contain_class('php::global') }
          it { is_expected.to contain_class('php::fpm') }
          it { is_expected.to contain_class('php::composer') }
          it { is_expected.to contain_package('php-pear').with_ensure('present') }
          it { is_expected.to contain_package("#{package_prefix}dev").with_ensure('present') }
          it { is_expected.to contain_package("#{package_prefix}fpm").with_ensure('present') }
        when 'Suse'
          it { is_expected.to contain_package('php5').with_ensure('present') }
          it { is_expected.to contain_package("#{package_prefix}devel").with_ensure('present') }
          it { is_expected.to contain_package("#{package_prefix}pear").with_ensure('present') }
          it { is_expected.not_to contain_package("#{package_prefix}cli").with_ensure('present') }
          it { is_expected.not_to contain_package("#{package_prefix}dev") }
          it { is_expected.not_to contain_package('php-pear') }
        when 'RedHat', 'CentOS'
          it { is_expected.to contain_package("#{package_prefix}common").with_ensure('present') }
        end
      end

      describe 'when called with fpm_user parameter' do
        let(:params) { { fpm_user: 'nginx' } }

        it { is_expected.to contain_class('php::fpm').with(user: 'nginx') }
        it { is_expected.to contain_php__fpm__pool('www').with(user: 'nginx') }

        dstfile = case facts[:osfamily]
                  when 'Debian'
                    case facts[:os]['release']['major']
                    when '16.04'
                      '/etc/php/7.0/fpm/pool.d/www.conf'
                    else
                      '/etc/php5/fpm/pool.d/www.conf'
                    end
                  when 'Archlinux'
                    '/etc/php/php-fpm.d/www.conf'
                  when 'Suse'
                    '/etc/php5/fpm/pool.d/www.conf'
                  when 'RedHat'
                    '/etc/php-fpm.d/www.conf'
                  when 'FreeBSD'
                    '/usr/local/etc/php-fpm.d/www.conf'
                  end

        it { is_expected.to contain_file(dstfile).with_content(%r{user = nginx}) }
      end
      describe 'when called with fpm_group parameter' do
        let(:params) { { fpm_group: 'nginx' } }

        it { is_expected.to contain_class('php::fpm').with(group: 'nginx') }
        it { is_expected.to contain_php__fpm__pool('www').with(group: 'nginx') }
        dstfile = case facts[:osfamily]
                  when 'Debian'
                    case facts[:os]['release']['major']
                    when '16.04'
                      '/etc/php/7.0/fpm/pool.d/www.conf'
                    else
                      '/etc/php5/fpm/pool.d/www.conf'
                    end
                  when 'Archlinux'
                    '/etc/php/php-fpm.d/www.conf'
                  when 'Suse'
                    '/etc/php5/fpm/pool.d/www.conf'
                  when 'RedHat'
                    '/etc/php-fpm.d/www.conf'
                  when 'FreeBSD'
                    '/usr/local/etc/php-fpm.d/www.conf'
                  end

        it { is_expected.to contain_file(dstfile).with_content(%r{group = nginx}) }
      end

      describe 'when fpm is disabled' do
        let(:params) { { fpm: false } }

        it { is_expected.not_to contain_class('php::fpm') }
      end

      describe 'when composer is disabled' do
        let(:params) { { composer: false } }

        it { is_expected.not_to contain_class('php::composer') }
      end

      if facts[:osfamily] == 'RedHat' || facts[:osfamily] == 'CentOS'
        describe 'when called with global option for rhscl_mode' do
          describe 'when called with mode "remi"' do
            scl_php_version = 'php56'
            rhscl_mode = 'remi'
            let(:pre_condition) do
              "class {'::php::globals':
                        php_version => '#{scl_php_version}',
                        rhscl_mode => '#{rhscl_mode}'
              }"
            end
            let(:params) do
              { settings: { 'Date/date.timezone' => 'Europe/Berlin' } }
            end

            it { is_expected.to contain_class('php::global') }
            it { is_expected.to contain_package("#{scl_php_version}-php-cli").with_ensure('present') }
            it { is_expected.to contain_package("#{scl_php_version}-php-common").with_ensure('present') }
            it { is_expected.to contain_php__config('global').with(file: "/etc/opt/#{rhscl_mode}/#{scl_php_version}/php.ini") }
            it { is_expected.not_to contain_php__config('cli') }

            # see: https://github.com/voxpupuli/puppet-php/blob/master/lib/puppet/parser/functions/to_hash_settings.rb
            it { is_expected.to contain_php__config__setting("/etc/opt/#{rhscl_mode}/#{scl_php_version}/php.ini: Date/date.timezone").with_value('Europe/Berlin') }
          end

          describe 'when called with mode "rhscl"' do
            scl_php_version = 'rh-php56'
            rhscl_mode = 'rhscl'
            let(:pre_condition) do
              "class {'::php::globals':
                        php_version => '#{scl_php_version}',
                        rhscl_mode => '#{rhscl_mode}'
              }"
            end
            let(:params) do
              { settings: { 'Date/date.timezone' => 'Europe/Berlin' } }
            end

            it { is_expected.to contain_class('php::global') }
            it { is_expected.to contain_package("#{scl_php_version}-php-cli").with_ensure('present') }
            it { is_expected.to contain_package("#{scl_php_version}-php-common").with_ensure('present') }
            it { is_expected.to contain_php__config('global').with(file: "/etc/opt/rh/#{scl_php_version}/php.ini") }
            it { is_expected.to contain_php__config('cli').with(file: "/etc/opt/rh/#{scl_php_version}/php-cli.ini") }
            it { is_expected.to contain_php__config__setting("/etc/opt/rh/#{scl_php_version}/php.ini: Date/date.timezone").with_value('Europe/Berlin') }
          end
        end
      end
    end
  end
end
