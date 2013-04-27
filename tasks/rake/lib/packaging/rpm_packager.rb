require 'base_packager'

class RpmPackager < BasePackager

  PACKAGETYPE = "rpm"

  def initialize()
    super(PACKAGETYPE)
  end

end
