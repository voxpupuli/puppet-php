# frozen_string_literal: true

# @summary Ensures a prefix for all elements in an array or the keys in a hash.
#
# This function ensures a prefix for all elements in an array or the keys in a hash.
# If called with an empty, or `nil` prefix, will return the original data.
#
# @example Calling the function with an Array
#   php::ensure_prefix(['a', 'p.b', 'c'], 'p.')
#   # Will return: ['p.a', 'p.b', 'p.c']
#
# @example Calling the function with a Hash
#   php::ensure_prefix({'a' => 1, 'b' => 2, 'p.c' => 3}, 'p.')
#   # Will return: {'p.a' => 1, 'p.b' => 2, 'p.c' => 3}
Puppet::Functions.create_function(:'php::ensure_prefix') do
  # @param enumerable An Array or Hash
  # @param prefix An empty prefix
  # @return Will return the original enumerable unmodified.
  dispatch :noop do
    param 'Variant[Array, Hash]', :enumerable
    param 'Variant[Undef, String[0,0]]', :prefix
    return_type 'Variant[Array[String], Hash[String, Any]]'
  end

  # @param array The input Array.
  # @param prefix A string that you want prefixed to all elements in the array if not already present.
  # @return The `array` with each element prefixed with `prefix`.
  dispatch :ensure_prefix_array do
    param 'Array',     :array
    param 'String[1]', :prefix
    return_type 'Array[String]'
  end

  # @param hash The input Hash.
  # @param prefix A string that you want prefixed to all keys in the hash if not already present.
  # @return The `hash` with each key prefixed with `prefix`.
  dispatch :ensure_prefix_hash do
    param 'Hash',      :hash
    param 'String[1]', :prefix
    return_type 'Hash[String, Any]'
  end

  def noop(enumerable, _prefix)
    enumerable
  end

  def ensure_prefix_array(array, prefix)
    array.map { |item| prefix_item(item, prefix) }
  end

  def ensure_prefix_hash(hash, prefix)
    hash.transform_keys { |key| prefix_item(key, prefix) }
  end

  private

  def prefix_item(raw, prefix)
    string = raw.to_s
    string.start_with?(prefix) ? string : prefix + string
  end
end
