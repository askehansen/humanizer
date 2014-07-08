# Humanizer

A library for *humazing* and *sanitizing* `Array` and `Hash`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'type-humanizer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install type-humanizer

## Usage

### Humanizing

*First, lets humanize some data*

 We can humanize an `Array` and a `Hash`

To do that, we just call `Humanizer::Human#from`

```ruby
Humanizer::Human.from ['a', 'b', 'c']
=> "a, b, c"

Humanizer::Human.from { :foo => 'bar', :boo => 'baz' }
=> "foo: bar, boo: baz"
```

### Sanitizing

*Now lets sanitize it*

Again, we can sanitize an `Array` and a `Hash`

For this we need the `Humanizer::Sanitize` class

```ruby
sanitizer = Humanizer::Sanitize.new

sanitizer.to_array 'a, b, c'
=> ["a", "b", "c"]

sanitizer.to_hash 'foo: bar, boo: baz'
=> { "foo" => "bar", "boo" => "baz" }
```
    
We can also sanitize a hash of params.. This could be some Rails params

All we need to do is pass the params and specify which params should be sanitized to what type

```ruby
params = { friends: 'Jack, Jill', favorites: 'drink: Coffee, fruit: Banana' }

Humanizer::Sanitize.params params, friends: :array, favorites: :hash
=> { :friends => ["Jack", "Jill"], :favorites => { "drink" => "Coffee", "fruit" => "Banana" } }
```

## Configuration

You can configure the delimeters by creating an initializer:

```ruby
Humanizer.configure do |config|
  # These are the default values
  config.array_delimeter   = ', '
  config.hash_delimeter    = ', '
  config.key_val_delimeter = ': '
end
```

## Contributing

1. Fork it ( https://github.com/askehansen/humanizer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
    
