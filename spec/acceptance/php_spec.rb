require 'spec_helper_acceptance'

describe 'php class' do
  context 'with default parameters' do
    pp = 'include php'
    it 'applies without error' do
      apply_manifest(pp, catch_failures: true)
    end
    it 'applies idempotently' do
      apply_manifest(pp, catch_changes: true)
    end

    case default[:platform]
    when %r{ubuntu-18.04}
      packagename = 'php7.2-fpm'
    when %r{ubuntu-16.04}
      packagename = 'php7.0-fpm'
    when %r{ubuntu-14.04}
      packagename = 'php5-fpm'
    when %r{el}
      packagename = 'php-fpm'
    when %r{debian-8}
      packagename = 'php5-fpm'
    when %r{debian-9}
      packagename = 'php7.0-fpm'
    when %r{debian-10}
      packagename = 'php7.3-fpm'
    end
    describe package(packagename) do
      it { is_expected.to be_installed }
    end

    describe service(packagename) do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end
  end
  context 'with extensions' do
    case default[:platform]
    when %r{ubuntu-18.04}, %r{ubuntu-16.04}
      case default[:platform]
      when %r{ubuntu-18.04}
        simplexmlpackagename = 'php7.2-xml'
      when %r{ubuntu-16.04}
        simplexmlpackagename = 'php7.0-xml'
      end
      pp = <<-EOS
        class{'php':
          extensions => {
            'mysql'    => {},
            'gd'       => {},
            'net-url'  => {
              package_prefix => 'php-',
              settings       => {
                extension => undef
              },
            },
            'simplexml'  => {
              package_name => '#{simplexmlpackagename}',
            }
          }
        }
      EOS
    when %r{ubuntu-14.04}
      pp = <<-EOS
        class{'php':
          extensions => {
            'mysql'    => {},
            'gd'       => {},
            'net-url'  => {
              package_prefix => 'php-',
              settings       => {
                extension => undef
              },
            }
          }
        }
      EOS
    else
      pp = <<-EOS
        class{'php':
          extensions => {
            'mysql'    => {},
            'gd'       => {}
          }
        }
      EOS
    end

    it 'applies without error' do
      apply_manifest(pp, catch_failures: true)
    end
    it 'applies idempotently' do
      apply_manifest(pp, catch_changes: true)
    end

    case default[:platform]
    when %r{ubuntu-18.04}
      packagename = 'php7.2-fpm'
    when %r{ubuntu-16.04}
      packagename = 'php7.0-fpm'
    when %r{ubuntu-14.04}
      packagename = 'php5-fpm'
    when %r{el}
      packagename = 'php-fpm'
    when %r{debian-8}
      packagename = 'php5-fpm'
    when %r{debian-9}
      packagename = 'php7.0-fpm'
    when %r{debian-10}
      packagename = 'php7.3-fpm'
    end
    describe package(packagename) do
      it { is_expected.to be_installed }
    end

    describe service(packagename) do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end
  end
end
