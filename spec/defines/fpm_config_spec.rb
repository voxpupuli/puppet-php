require 'spec_helper'

describe 'php::fpm::config' do

  context 'valid config' do
    let(:title) { 'unique-name' }
    let(:params) {{
      :file   => '/etc/php5/conf.d/unique-name.ini',
      :config => [
        'set .anon/apc.enabled 1'
      ]
    }}

    it { should contain_php__fpm__config('unique-name')
      .with({
        'file'    => '/etc/php5/conf.d/unique-name.ini',
        'config'  => ['set .anon/apc.enabled 1']
      })
    }

    it { should contain_php__config('fpm-unique-name')
      .with({
        'file'    => '/etc/php5/conf.d/unique-name.ini',
        'config'  => ['set .anon/apc.enabled 1']
      })
      .that_notifies('php5-fpm')
    }

    it { should contain_augeas("php-fpm-unique-name-config")
      .with({
        'file'    => '/etc/php5/conf.d/unique-name.ini',
        'changes' => "set .anon/apc.enabled 1"
      })
    }

  end

  context 'invalid config (string)' do
    let(:title) { 'unique-name' }
    let(:params) {{
      :file => '/etc/php5/conf.d/unique-name.ini',
      :config => 'hello world'
    }}

    it { expect { should raise_error(Puppet::Error) }}
  end

end
