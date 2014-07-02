require "humanizer/version"

module Humanizer
  class Sanitize
    def to_array(value)
      value = String(value)

      array = String(value).split ','
      array.map &:strip
    end

    def to_hash(value)
      value = String(value)
      hash = {}
      
      value.split(',').each do |key_val|
        k, v = key_val.split(':')
        k = String(k)
        v = String(v)
        hash[k.strip] = v.strip
      end

      hash
    end

    def from(value, to: nil)
      self.send "to_#{to}", value
    end

    def self.params(params, options)
      params = Hash(params)
      options = Hash(options)

      sanitizer = Sanitize.new

      options.each do |param, type|
        params[param] = sanitizer.from params[param], to: type
      end

      params
    end
  end

  class Human
    def self.from(value)
      type = value.class.to_s.downcase
      human = Human.new

      human.send "from_#{type}", value
    end

    def from_array(value)
      value = Array(value)
      
      value.join ', '
    end

    def from_hash(value)
      value = Hash(value)

      value = value.map do |k, v|
        "#{k}: #{v}"
      end

      value.join(', ')
    end

    def method_missing(name, *args)
      args[0]
    end
  end
end
