require 'spec_helper'

describe 'php::repo::debian', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      let :pre_condition do
        [
          'class { "php":; }',
        ]
      end

      case facts[:lsbdistcodename]
      when 'wheezy'
        describe 'when call with defaults on Debian wheezy' do
          it { is_expected.to contain_apt__key('php::repo::debian').with({
              'id' => '6572BBEF1B5FF28B28B706837E3F070089DF5277',
              'source' => 'http://www.dotdeb.org/dotdeb.gpg'
            })
          }

          it { is_expected.to contain_apt__source('source_php_wheezy-php56').with({
              'location'    => 'http://packages.dotdeb.org',
              'release'     => 'wheezy-php56',
              'repos'       => 'all',
              'include_src' => 'false',
            })
            .that_requires('Apt::Key[php::repo::debian]')
        }
        end

        describe 'when call with version 7.0 on Debian wheezy' do
          let(:params) do
            {
              version: '7.0'
            }
          end
          it { expect { is_expected.to raise_error(Puppet::Error) } }
        end

        describe 'when call with version 7.1 on Debian wheezy' do
          let(:params) do
            {
              version: '7.1'
            }
          end
          it { expect { is_expected.to raise_error(Puppet::Error) } }
        end

      when 'jessie'
        describe 'when called with no parameters on Debian jessie' do
          it { is_expected.to contain_apt__key('php::repo::debian').with({
              'id' => '6572BBEF1B5FF28B28B706837E3F070089DF5277',
              'source' => 'http://www.dotdeb.org/dotdeb.gpg'
            })
          }
        end

        describe 'when called with version 7.0 on Debian jessie' do
          let(:params) do
            {
              version: '7.0'
            }
          end
          it { is_expected.to contain_apt__key('php::repo::debian').with({
              'id' => '6572BBEF1B5FF28B28B706837E3F070089DF5277',
              'source' => 'http://www.dotdeb.org/dotdeb.gpg'
            })
          }

          it { is_expected.to contain_apt__source('source_php_jessie').with({
              'location'    => 'http://packages.dotdeb.org',
              'release'     => 'jessie',
              'repos'       => 'all',
              'include_src' => 'false',
            })
            .that_requires('Apt::Key[php::repo::debian]')
          }
        end
      end
    end
  end
end
