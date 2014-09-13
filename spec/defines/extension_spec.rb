require 'spec_helper'

describe 'php::extension' do
  let(:facts) { {  :osfamily => 'Debian',
                   :path     => '/usr/local/bin:/usr/bin:/bin' } }
  let(:pre_condition) { 'include php::params' }

  context 'pecl installation' do
    let(:title) { 'json' }
    let(:params) {{
      :settings => {
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

  context 'with an undetermined php version' do
    let(:facts) { {
      :osfamily    => 'Debian',
      :php_version => ''
    } }
    let(:title) { 'xdebug' }

    it {
      should contain_php__config('xdebug').with({
        :file => '/etc/php5/mods-available/xdebug.ini',
      })
    }
  end

  context 'with php 5.3' do
    let(:facts) { {
      :osfamily    => 'Debian',
      :php_version => '5.3'
    } }
    let(:title) { 'xdebug' }

    it {
      should contain_php__config('xdebug').with({
        :file => '/etc/php5/conf.d/xdebug.ini',
      })
    }
  end

  context 'with php 5.4' do
    let(:facts) { {
      :osfamily    => 'Debian',
      :php_version => '5.4'
    } }
    let(:title) { 'xdebug' }

    it {
      should contain_php__config('xdebug').with({
        :file => '/etc/php5/mods-available/xdebug.ini',
      })
    }
  end

  context 'with php 5.4.1' do
    let(:facts) { {
      :osfamily    => 'Debian',
      :php_version => '5.4.1'
    } }
    let(:title) { 'xdebug' }

    it {
      should contain_php__config('xdebug').with({
        :file => '/etc/php5/mods-available/xdebug.ini',
      })
    }
  end

  context 'with php 5.5' do
    let(:facts) { {
      :osfamily    => 'Debian',
      :php_version => '5.5'
    } }
    let(:title) { 'xdebug' }

    it {
      should contain_php__config('xdebug').with({
        :file => '/etc/php5/mods-available/xdebug.ini',
      })
    }
  end

  context 'with php 5.5.11-1~dotdeb.1' do
    let(:facts) { {
      :osfamily    => 'Debian',
      :php_version => '5.5.11-1~dotdeb.1'
    } }
    let(:title) { 'xdebug' }

    it {
      should contain_php__config('xdebug').with({
        :file => '/etc/php5/mods-available/xdebug.ini',
      })
    }
  end

end
