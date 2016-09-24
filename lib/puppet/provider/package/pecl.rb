require 'puppet/provider/package'

Puppet::Type.type(:package).newparam(:pipe)
Puppet::Type.type(:package).provide :pecl, parent: Puppet::Provider::Package do
  desc 'PHP pecl support. By default uses the installed channels, but you can specify the path to a pecl package via ``source``.'

  has_feature :versionable
  has_feature :upgradeable

  case Facter.value(:operatingsystem)
  when 'Solaris'
    commands peclcmd: '/opt/coolstack/php5/bin/pecl'
  else
    commands peclcmd: 'pecl'
  end

  def self.pecllist(hash)
    command = [command(:peclcmd), 'list']

    begin
      list = execute(command).split("\n").map do |set|
        if hash[:justme]
          if %r{^#{hash[:justme]}$}i =~ set
            if peclhash = peclsplit(set) # rubocop:disable Lint/AssignmentInCondition
              peclhash[:provider] = :peclcmd
              peclhash
            end
          end
        elsif peclhash = peclsplit(set) # rubocop:disable Lint/AssignmentInCondition
          peclhash[:provider] = :peclcmd
          peclhash
        end
      end.reject(&:nil?)
    rescue Puppet::ExecutionFailure => detail
      raise Puppet::Error, format('Could not list pecls: %s', detail)
    end

    return list.shift if hash[:justme]
    list
  end

  def self.peclsplit(desc)
    desc.strip!

    case desc
    when %r{^INSTALLED} then return nil
    when %r{No packages installed from channel}i then return nil
    when %r{^=} then return nil
    when %r{^PACKAGE} then return nil
    when %r{\[1m} then return nil # Newer versions of PEAR use colorized output
    when %r{^(\S+)\s+(\S+)\s+\S+} then
      name = Regexp.last_match(1)
      version = Regexp.last_match(2)

      return {
        name: "pecl-#{name.downcase}",
        ensure: version
      }
    else
      Puppet.warning format('Could not match %s', desc)
      nil
    end
  end

  def self.instances
    pecllist(local: true).map do |hash|
      new(hash)
    end
  end

  def peclname
    name.sub('pecl-', '').downcase
  end

  def install(useversion = true)
    command = ['upgrade']

    if @resource[:source]
      command << @resource[:source]
    elsif (!@resource.should(:ensure).is_a? Symbol) && useversion
      command << '-f'
      command << "#{peclname}-#{@resource.should(:ensure)}"
    else
      command << peclname
    end

    if pipe == @resource[:pipe]
      command << '<<<'
      command << @resource[:pipe]
    end

    peclcmd(*command)
  end

  def latest
    version = ''
    command = [command(:peclcmd), 'remote-info', peclname]
    execute(command).each_line do |set|
      version = set.split[1] if set =~ %r{^Latest}
    end

    version
  end

  def query
    self.class.pecllist(justme: peclname)
  end

  def uninstall
    output = peclcmd 'uninstall', peclname
    raise Puppet::Error, output unless output =~ %r{^uninstall ok}
  end

  def update
    install(false)
  end
end
