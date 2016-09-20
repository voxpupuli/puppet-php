require 'spec_helper'

describe 'php::fpm::config' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      case facts[:operatingsystem]
      when 'Ubuntu'
        describe 'creates config file' do
          let(:params) do
            {
              inifile: '/etc/php/5.6/conf.d/unique-name.ini',
              settings: {
                'apc.enabled' => 1
              }
            }
          end

          it do
            is_expected.to contain_class('php::fpm::config').with(
              inifile: '/etc/php/5.6/conf.d/unique-name.ini',
              settings: {
                'apc.enabled' => 1
              }
            )
          end

          it do
            is_expected.to contain_php__config('fpm').with(
              file: '/etc/php/5.6/conf.d/unique-name.ini',
              config: {
                'apc.enabled' => 1
              }
            )
          end
        end
      else
        describe 'creates config file' do
          let(:params) do
            {
              inifile: '/etc/php5/conf.d/unique-name.ini',
              settings: {
                'apc.enabled' => 1
              }
            }
          end

          it do
            is_expected.to contain_class('php::fpm::config').with(
              inifile: '/etc/php5/conf.d/unique-name.ini',
              settings: {
                'apc.enabled' => 1
              }
            )
          end

          it do
            is_expected.to contain_php__config('fpm').with(
              file: '/etc/php5/conf.d/unique-name.ini',
              config: {
                'apc.enabled' => 1
              }
            )
          end
        end
      end
    end
  end
end
