require 'spec_helper_acceptance'

describe 'php class' do
  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        class { 'php':
          settings => {
            'PHP/short_open_tag' => 'On'
          }
        }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe port(9000) do
      it { should be_listening }
    end

    describe php_config('short_open_tag') do
      its(:value) { should eq 1 }
    end
  end
end

