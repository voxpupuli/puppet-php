
require 'spec_helper'

describe 'php::config' do

  context 'simple README example' do
    let(:title) { 'unique-name' }
    let(:params) {{
      :inifile => '/etc/php5/conf.d/unique-name.ini',
      :settings => {
        'set' => {
          '.anon/apc.enabled' => 1
        }
      }
    }}

    it { should contain_php__config('unique-name').with({ 'inifile' => '/etc/php5/conf.d/unique-name.ini'} )}
    it { should contain_augeas("php-unique-name-config").with({ 'changes' => "  set '.anon/apc.enabled' '1'\n" })}
  end


end
