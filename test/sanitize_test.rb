require 'test/unit'
require 'type-humanizer'

class SanitizeTest < Test::Unit::TestCase
  def test_sanitize_array
    sanitizer = Humanizer::Sanitize.new

    assert_equal ['a', 'b', 'c'], sanitizer.to_array('a, b, c')
    assert_equal ['d', 'e', 'f'], sanitizer.to_array('d,e,f')
    assert_equal ['1', '2', '3'], sanitizer.to_array('1, 2, 3')
    assert_equal ['4', '5', '6'], sanitizer.to_array('4,5,6')
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