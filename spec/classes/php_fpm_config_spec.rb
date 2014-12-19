require 'spec_helper'

describe 'php::fpm::config' do
  let(:facts) { { :osfamily => 'Debian' } }

  context 'creates config file' do
    let(:params) {{
      :inifile  => '/etc/php5/conf.d/unique-name.ini',
      :settings => {
        'apc.enabled' => 1,
      },
    }}

    it { should contain_class('php::fpm::config').with({
      :inifile  => '/etc/php5/conf.d/unique-name.ini',
      :settings => {
        'apc.enabled' => 1,
      },
    })}

    it { should contain_php__config('fpm').with({
      :file   => '/etc/php5/conf.d/unique-name.ini',
      :config => {
        'apc.enabled' => 1,
      },
    })}
  end
end
