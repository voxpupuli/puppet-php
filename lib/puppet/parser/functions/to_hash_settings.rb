
module Puppet::Parser::Functions
  newfunction(:to_hash_settings, :type => :rvalue, :doc => <<-EOS
This function converts a {key => value} hash into a nested hash and adds an id to the outer key.

*Examples:*

hashify({'a' => 1, 'b' => 2})

Would return: {
  'a' => {'value' => 1},
  'b' => {'value' => 2}
}
EOS
  ) do |arguments|

    raise(Puppet::ParseError, "hashify(): Wrong number of arguments " +
      "given (#{arguments.size} for 2)") if arguments.size < 2

    hash = arguments[0]
    id = arguments[1]

    unless hash.is_a?(Hash)
      raise(Puppet::ParseError, 'hashify(): Requires hash to work with')
    end

    result = hash.reduce({}) { |acc, kv|
      acc.inspect
      kv.inspect
      acc[id + ': ' + kv[0]] = {'key' => kv[0] ,'value' => kv[1]}
      acc
    }

    return result
  end
end
