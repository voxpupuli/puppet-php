require 'spec_helper'

describe 'php::extension' do
  let(:facts) { {  :osfamily => 'Debian',
                   :path     => '/usr/local/bin:/usr/bin:/bin' } }
  let(:pre_condition) { 'include php::params' }

  context 'installation from repository' do
    let(:title) { 'json' }
    let(:params) {{
      :package_prefix => 'php5-',
      :settings       => {
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

  context 'non-pecl extensions cannot be configured as zend' do
    let(:title) { 'xdebug' }
    let(:params) {{
      :zend => true,
    }}

    it { expect { should raise_error(Puppet::Error) }}
  end

  context 'pecl installation' do
    let(:title) { 'json' }
    let(:params) {{
      :provider        => 'pecl',
      :header_packages => ['libmemcached-dev'],
      :name            => 'nice_name',
      :settings        => {
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

  context 'pecl extensions can be configured as zend' do
    let(:facts) {{
      :osfamily              => 'Debian',
      :php_extension_version => '20100525'
    }}
    let(:title) { 'xdebug' }
    let(:params) {{
      :provider => 'pecl',
      :zend     => true
    }}

    it {
      should contain_php__config('xdebug').with({
        :config => {
          'zend_extension' => '/usr/lib/php5/20100525/xdebug.so'
        }
      })
    }
  end

  context 'pecl extensions support pecl_name' do
    let(:facts) {{
      :osfamily              => 'Debian',
      :php_extension_version => '20100525'
    }}
    let(:title) { 'opcache' }
    let(:params) {{
      :provider  => 'pecl',
      :zend      => true,
      :pecl_name => 'zendopcache'
    }}

    it {
      should contain_php__config('opcache').with({
        :config => {
          'zend_extension' => '/usr/lib/php5/20100525/opcache.so'
        }
      })
    }
  end

  context 'on Debian' do
    let(:facts) { {
      :osfamily    => 'Debian',
    } }
    let(:title) { 'xdebug' }

    it {
      should contain_php__config('xdebug').with({
        :file => '/etc/php5/mods-available/xdebug.ini',
      })
    }
  end
end
