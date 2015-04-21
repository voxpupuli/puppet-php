# thanks to Christian Winter (jippi@github) for 
# https://github.com/jippi/puppet-php/blob/master/lib/facter/php_extension_version.rb

Facter.add(:php_extension_version) do
  setcode do
    module_api_version = Facter::Util::Resolution.exec("/usr/bin/env php -i 2>/dev/null | awk '/PHP Extension =/{print $4}'")
    if module_api_version
      module_api_version.match(/(\d{8})/).to_s
    else
      "20100525"
    end
  end
end
