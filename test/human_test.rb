require 'test/unit'
require 'type-humanizer'

class HumanTest < Test::Unit::TestCase
  def test_humanize_array
    humanizer = Humanizer::Human.new

    assert_equal 'a, b, c', humanizer.from_array(['a, b, c'])
    assert_equal '', humanizer.from_array(nil)
   end

   def test_humanize_hash
    humanizer = Humanizer::Human.new

     assert_equal 'foo: bar, boo: baz', humanizer.from_hash({ foo: :bar, boo: :baz })
     assert_equal '', humanizer.from_hash(nil)
   end

   def test_human_from
    assert_equal 'foo', Humanizer::Human.from('foo')
    assert_equal nil, Humanizer::Human.from(nil)
   end
end