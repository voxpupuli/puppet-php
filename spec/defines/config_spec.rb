require 'spec_helper'

describe 'php::config' do
  let(:facts) { {  :osfamily => 'Debian',
                    :path     => '/usr/local/bin:/usr/bin:/bin' } }

  context 'default config' do
    let(:title) { 'unique-name' }
    let(:params) {{
      :file   => '/etc/php5/conf.d/unique-name.ini',
      :config => {}
    }}
  end

  context 'simple example' do
    let(:title) { 'unique-name' }
    let(:params) {{
      :file   => '/etc/php5/conf.d/unique-name.ini',
      :config => {
        'apc.enabled' => 1
      }
    }}

    it { should contain_php__config('unique-name').with({'file' => '/etc/php5/conf.d/unique-name.ini'})}
  end

  context 'empty array' do
    let(:title) { 'unique-name' }
    let(:params) {{
      :file   => '/etc/php5/conf.d/unique-name.ini',
      :config => {}
    }}

    it { should contain_php__config('unique-name').with({'file' => '/etc/php5/conf.d/unique-name.ini'})}
  end

  context 'invalid config (string)' do
    let(:title) { 'unique-name' }
    let(:params) {{
      :file   => '/etc/php5/conf.d/unique-name.ini',
      :config => 'hello world'
    }}

    it { expect { should raise_error(Puppet::Error) }}
  end

end
