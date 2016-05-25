require 'spec_helper'

describe 'php::repo::ubuntu', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      case facts[:lsbdistcodename]
      when 'trusty'
        describe 'when called with no parameters on Ubuntu trusty' do
          it {
            should contain_exec('add-apt-repository-ppa:ondrej/php')
          }
        end

        describe 'when called with parameter oldstable on Ubuntu trusty' do
          let(:params) {{
              :version => '7.0'
          }}
          it {
            should contain_exec('add-apt-repository-ppa:ondrej/php')
          }
        end

        describe 'when call with parameter ppa without prefix "ppa:" on Ubuntu trusty' do
          let(:params) {{
              :ppa => 'ondrej/php'
          }}
          it {
            should contain_exec('add-apt-repository-ppa:ondrej/php')
          }
        end

        describe 'when call with parameter ppa and version on Ubuntu trusty' do
          let(:params) {{
              :version => '5.4',
              :ppa     => 'ondrej/php5-oldstable'
          }}
          it { expect { should raise_error(Puppet::Error) }}
        end

      end
    end
  end
end
