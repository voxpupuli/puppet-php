
module Puppet::Parser::Functions
  newfunction(:hashify, :type => :rvalue, :doc => <<-EOS
This function converts a key => value into a nested hash.

*Examples:*

hashify({'a' => 1, 'b' => 2})

Would return: {
  'a' => {'value' => 1},
  'b' => {'value' => 2}
}
EOS
  ) do |arguments|

    raise(Puppet::ParseError, "hashify(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)") if arguments.size < 1

    hash = arguments[0]

    unless hash.is_a?(Hash)
      raise(Puppet::ParseError, 'hashify(): Requires hash to work with')
    end

    result = hash.reduce({}) { |acc, kv|
      acc.inspect
      kv.inspect
      acc[kv[0]] = {'value' => kv[1]}
      acc
    }

    return result
  end
end
