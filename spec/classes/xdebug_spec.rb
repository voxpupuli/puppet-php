require 'spec_helper'

describe 'php::extension::xdebug' do
  let :pre_condition do
    'include "php"'
  end

  context 'with an undetermined php version' do
    let(:facts) { { :php_version => '' } }

    it { should contain_augeas("php-php-extension-xdebug-config")
      .with({
        :incl      => '/etc/php5/mods-available/xdebug.ini',
      })
    }
  end

  context 'with php 5.3' do
    let(:facts) { { :php_version => '5.3'} }

    it { should contain_augeas("php-php-extension-xdebug-config")
      .with({
        :incl      => '/etc/php5/conf.d/xdebug.ini',
      })
    }
  end

  context 'with php 5.4' do
    let(:facts) { { :php_version => '5.4'} }

    it { should contain_augeas("php-php-extension-xdebug-config")
      .with({
        :incl      => '/etc/php5/mods-available/xdebug.ini',
      })
    }
  end

  context 'with php 5.4.1' do
    let(:facts) { { :php_version => '5.4.1'} }

    it { should contain_augeas("php-php-extension-xdebug-config")
      .with({
        :incl      => '/etc/php5/mods-available/xdebug.ini',
      })
    }
  end

  context 'with php 5.5' do
    let(:facts) { { :php_version => '5.5'} }

    it { should contain_augeas("php-php-extension-xdebug-config")
      .with({
        :incl      => '/etc/php5/mods-available/xdebug.ini',
      })
    }
  end
  
  context 'with php 5.5.11-1~dotdeb.1' do
    let(:facts) { { :php_version => '5.5'} }

    it { should contain_augeas("php-php-extension-xdebug-config")
      .with({
        :incl      => '/etc/php5/mods-available/xdebug.ini',
      })
    }
  end
  
end
