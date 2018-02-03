require 'spec_helper_acceptance'

describe 'php' do
  it 'works' do
    pp = 'include php'
    # Run it twice and test for idempotency
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  describe package('php7.0-fpm') do
    it { is_expected.to be_installed }
  end
end
