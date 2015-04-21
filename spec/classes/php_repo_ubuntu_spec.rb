require 'spec_helper'

describe 'php::repo::ubuntu', :type => :class do
  describe 'when called with no parameters on Ubuntu trusty' do
    let(:facts) {{
      :osfamily        => 'Debian',
      :operatingsystem => 'Ubuntu',
      :lsbdistid       => 'Ubuntu',
      :lsbdistcodename => 'trusty'
    }}

    it {
      should contain_exec('add-apt-repository-ppa:ondrej/php5')
    }
  end

  describe 'when called with no parameters on Ubuntu precise' do
    let(:facts) {{
      :osfamily        => 'Debian',
      :operatingsystem => 'Ubuntu',
      :lsbdistid       => 'Ubuntu',
      :lsbdistcodename => 'precise'
    }}

    it {
      should contain_exec('add-apt-repository-ppa:ondrej/php5-oldstable')
    }
  end

  describe 'when called with parameter oldstable' do
    let(:facts) {{
      :osfamily => 'Debian',
      :osfamily        => 'Debian',
      :operatingsystem => 'Ubuntu',
      :lsbdistid       => 'Ubuntu',
      :lsbdistcodename => 'trusty'
    }}
    let(:params) {{
      :oldstable => true
    }}

    it {
      should contain_exec('add-apt-repository-ppa:ondrej/php5-oldstable')
    }
  end
end
