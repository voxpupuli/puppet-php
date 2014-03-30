require 'spec_helper'

describe 'php::config' do

  context 'default config' do
    let(:title) { 'unique-name' }
    let(:params) {{
      :file   => '/etc/php5/conf.d/unique-name.ini',
      :config => []
    }}

    it { should contain_augeas("php-unique-name-config")
      .with({
        :incl      => '/etc/php5/conf.d/unique-name.ini',
        :changes   => [],
        :load_path => '/usr/share/augeas/lenses/contrib',
        :lens      => 'PHP.lns'
      })
    }
  end

  context 'simple example' do
    let(:title) { 'unique-name' }
    let(:params) {{
      :file   => '/etc/php5/conf.d/unique-name.ini',
      :config => [
        'set .anon/apc.enabled 1'
      ]
    }}

    it { should contain_php__config('unique-name').with({'file' => '/etc/php5/conf.d/unique-name.ini'})}
    it { should contain_augeas("php-unique-name-config").with({'changes' => "set .anon/apc.enabled 1"})}
  end

  context 'empty array' do
    let(:title) { 'unique-name' }
    let(:params) {{
      :file   => '/etc/php5/conf.d/unique-name.ini',
      :config => []
    }}

    it { should contain_php__config('unique-name').with({'file' => '/etc/php5/conf.d/unique-name.ini'})}
    it { should contain_augeas("php-unique-name-config").with({ }) }
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
