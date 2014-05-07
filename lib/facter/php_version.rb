Facter.add(:php_version) do
  confine :kernel => :linux
  setcode do
    version = Facter::Util::Resolution.exec("/usr/bin/php --version | grep '^PHP ' | awk '{print $2}'")
    if version
      version.match(/(\d+\.\d+\.\d+)/).to_s
    else
      nil
    end
  end
end
