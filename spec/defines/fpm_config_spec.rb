require 'spec_helper'

describe 'php::fpm::config' do
  let(:facts) { {  :osfamily => 'Debian',
                   :path     => '/usr/local/bin:/usr/bin:/bin' } }

  context 'valid config' do
    let(:title) { 'unique-name' }
    let(:params) {{
      :file   => '/etc/php5/conf.d/unique-name.ini',
      :config => [
        'set .anon/apc.enabled 1'
      ]
    }}

    it { should contain_php__fpm__config('unique-name').with({
        'file'    => '/etc/php5/conf.d/unique-name.ini',
        'config'  => ['set .anon/apc.enabled 1']
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
