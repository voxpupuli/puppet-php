require 'spec_helper'

describe 'php::fpm::pool' do
  let(:facts) { { :osfamily => 'Debian' } }

  context 'plain config' do
    let(:title) { 'unique-name' }
    let(:params) {{ }}

    it { should contain_file('/etc/php5/fpm/pool.d/unique-name.conf') }
  end
end
