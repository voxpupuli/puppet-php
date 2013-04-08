require 'base_packager'

class DebPackager < BasePackager

  PACKAGETYPE = "deb"

  def initialize()
    super(PACKAGETYPE)
  end

end
