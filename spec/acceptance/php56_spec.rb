require 'spec_helper_acceptance'

describe 'with specific php version' do
  context 'with params' do
    it 'works with 5.6' do
      pp = <<-EOS
      class { 'php::globals':
        php_version => '5.6',
      }
      -> class { 'php':
        ensure       => 'present',
        manage_repos => true,
        fpm          => true,
        dev          => true,
        composer     => true,
        pear         => true,
        phpunit      => false,
      }
      EOS
      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    case default[:platform]
    when %r{16.04}
      describe package('php5.6-fpm') do
        it { is_expected.to be_installed }
      end
    when %r{14.04}
      describe package('php5.6-fpm') do
        it { is_expected.to be_installed }
      end
    end
  end
end
