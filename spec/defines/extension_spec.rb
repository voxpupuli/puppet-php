require 'spec_helper'

describe 'php::extension' do
  let(:facts) { {  :osfamily => 'Debian',
                   :path     => '/usr/local/bin:/usr/bin:/bin' } }
  let(:pre_condition) { 'include php::params' }

  context 'pecl installationg' do
    let(:title) { 'json' }
    let(:params) {{
      :config          => {
        'test' => 'foo'
      }
    }}

    it {
      should contain_package('php5-json')
      should contain_php__config('json').with({
        :file   => '/etc/php5/mods-available/json.ini',
        :config => {
          'test' => 'foo'
        },
      })
    }
  end


  context 'pecl installationg' do
    let(:title) { 'json' }
    let(:params) {{
      :provider        => 'pecl',
      :header_packages => ['libmemcached-dev'],
      :name            => 'nice_name',
      :config          => {
        'test' => 'foo'
      }
    }}

    it {
      should contain_package('pecl-json')
      should contain_package('libmemcached-dev')
      should contain_package('build-essential')
      should contain_php__config('json').with({
        :file   => '/etc/php5/mods-available/json.ini',
        :config => {
          'extension' => 'nice_name.so',
          'test'      => 'foo'
        },
      })
    }
  end
end
