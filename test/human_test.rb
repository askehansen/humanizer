require 'test/unit'
require 'humanizer'

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
end