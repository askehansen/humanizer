require 'test/unit'
require 'humanizer'

class SanitizeTest < Test::Unit::TestCase
  def test_sanitize_array
    sanitizer = Humanizer::Sanitize.new

    assert_equal ['a', 'b', 'c'], sanitizer.to_array('a, b, c')
    assert_equal ['a'], sanitizer.to_array('a')
    assert_equal nil, sanitizer.to_array('')
    assert_equal nil, sanitizer.to_array(nil)
  end

  def test_sanitize_hash
    sanitizer = Humanizer::Sanitize.new

    assert_equal({ 'foo' => 'bar', 'boo' => 'baz' }, sanitizer.to_hash('foo: bar, boo: baz'))
    assert_equal(nil, sanitizer.to_hash(''))
    assert_equal(nil, sanitizer.to_hash(nil))
  end

  def test_sanitize_params
    sanitizer = Humanizer::Sanitize.new

    params = { foo: 'b, a, r', boo: 'val: baz', 'boo' => 'b, a, z' }
    params = Humanizer::Sanitize.params params, foo: :array, boo: :hash, 'boo' => :array

    assert_equal({foo: ['b', 'a', 'r'], boo: { 'val' => 'baz' }, 'boo' => ['b', 'a', 'z'] }, params)
  end
end