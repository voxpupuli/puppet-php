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
            should contain_exec('add-apt-repository-ppa:ondrej/php5')
          }
        end

        describe 'when called with parameter oldstable on Ubuntu trusty' do
          let(:params) {{
              :oldstable => true
          }}
          it {
            should contain_exec('add-apt-repository-ppa:ondrej/php5-oldstable')
          }
        end

        describe 'when call with parameter ppa without prefix "ppa:" on Ubuntu trusty' do
          let(:params) {{
              :ppa => 'ondrej/php5-5.6'
          }}
          it {
            should contain_exec('add-apt-repository-ppa:ondrej/php5-5.6')
          }
        end

        describe 'when call with parameter ppa and oldstable on Ubuntu trusty' do
          let(:params) {{
              :oldstable => true,
              :ppa       => 'ondrej/php5-5.6'
          }}
          it { expect { should raise_error(Puppet::Error) }}
        end

      when 'precise'
      describe 'when called with no parameters on Ubuntu precise' do
        it {
          should contain_exec('add-apt-repository-ppa:ondrej/php5-oldstable')
        }
      end
      end
    end
  end
end