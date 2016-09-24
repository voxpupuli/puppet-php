require 'puppet/provider/package'

# PHP PEAR support.
Puppet::Type.type(:package).provide :pear, parent: Puppet::Provider::Package do
  desc 'PHP PEAR support. By default uses the installed channels, but you can specify the path to a pear package via ``source``.'

  has_feature :versionable
  has_feature :upgradeable
  has_feature :install_options

  case Facter.value(:operatingsystem)
  when 'Solaris'
    commands pearcmd: '/opt/coolstack/php5/bin/pear'
  else
    commands pearcmd: 'pear'
  end

  def self.pearlist(hash)
    command = [command(:pearcmd), 'list', '-a']
    channel = 'pear'

    begin
      list = execute(command).split("\n")
      list = list.map do |set|
        %r{INSTALLED PACKAGES, CHANNEL (.*):}i.match(set) { |m| channel = m[1].downcase }

        if hash[:justme]
          if set =~ %r{^#{hash[:justme]}}
            pearhash = pearsplit(set, channel)
            pearhash[:provider] = :pear
            pearhash
          end
        elsif pearhash = pearsplit(set, channel) # rubocop:disable Lint/AssignmentInCondition
          pearhash[:provider] = :pear
          pearhash
        end
      end.reject(&:nil?)

    rescue Puppet::ExecutionFailure => detail
      raise Puppet::Error, format('Could not list pears: %s', detail)
    end

    return list.shift if hash[:justme]
    list
  end

  def self.pearsplit(desc, channel)
    desc.strip!

    case desc
    when %r{^$} then return nil
    when %r{^INSTALLED}i then return nil
    when %r{no packages installed}i then return nil
    when %r{^=} then return nil
    when %r{^PACKAGE}i then return nil
    when %r{^(\S+)\s+(\S+)\s+(\S+)\s*$} then
      name = Regexp.last_match(1)
      version = Regexp.last_match(2)
      state = Regexp.last_match(3)
      return {
        name: "#{channel}/#{name}",
        ensure: state == 'stable' ? version : state
      }
    else
      Puppet.debug format("Could not match '%s'", desc)
      nil
    end
  end

  def self.instances
    pearlist(local: true).map do |hash|
      new(hash)
    end
  end

  def install(useversion = true)
    command = ['-D', 'auto_discover=1', 'upgrade']
    command << if @resource[:install_options]
                 @resource[:install_options]
               else
                 '--alldeps'
               end

    command << if @resource[:source]
                 @resource[:source]
               elsif (!@resource.should(:ensure).is_a? Symbol) && useversion
                 "#{@resource[:name]}-#{@resource.should(:ensure)}"
               else
                 @resource[:name]
               end

    pearcmd(*command)
  end

  def latest
    # This always gets the latest version available.
    version = ''
    command = [command(:pearcmd), 'remote-info', @resource[:name]]
    execute(command).each_line do |set|
      version = set.split[1] if set =~ %r{^Latest}
    end

    version
  end

  def query
    self.class.pearlist(justme: @resource[:name])
  end

  def uninstall
    output = pearcmd 'uninstall', @resource[:name]
    raise Puppet::Error, output unless output =~ %r{^uninstall ok}
  end

  def update
    install(false)
  end
end
