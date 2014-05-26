Facter.add(:php_version) do
  confine :kernel => :linux
  setcode do
    version = Facter::Util::Resolution.exec("/usr/bin/env php -r 'echo PHP_VERSION;' 2>/dev/null")
    if version
      version.match(/(\d+\.\d+\.\d+)/).to_s
    else
      nil
    end
  end
end
