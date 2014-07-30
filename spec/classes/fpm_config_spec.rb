require 'spec_helper'

describe 'php::fpm::config' do
  let(:facts) { { :osfamily => 'Debian' } }

  context 'creates config file' do
    let(:params) {{
      :php_inifile => '/etc/php5/conf.d/unique-name.ini',
      :php_config  => {
        'apc.enabled' => 1,
      },
    }}

    it { should contain_php__fpm__config('unique-name').with({
      :php_inifile => '/etc/php5/conf.d/unique-name.ini',
      :php_config  => {
        'apc.enabled' => 1,
      },
    })}

    it { should contain_file('/etc/php5/conf.d/unique-name.ini').with({
      :ensure  => 'present',
      :content => 'apc.enabled = 1',
    })}
  end

end
