module Humanizer
  class << self

    def config=(data)
      @config = data
    end

    def config
      @config ||= Config.new
      @config
    end

    def configure(&proc)
      @config ||= Config.new
      yield @config
    end
  end

  class Sanitize
    def to_array(value)
      value = String(value)

      return nil if value.empty?

      array = String(value).split Humanizer.config.array_delimeter
      array.map &:strip
    end

    def to_hash(value)
      value = String(value)
      hash = {}

      return nil if value.empty?
      
      value.split(Humanizer.config.hash_delimeter).each do |key_val|
        k, v = key_val.split(Humanizer.config.key_val_delimeter)
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
      
      value.join "#{Humanizer.config.array_delimeter} "
    end

    def from_hash(value)
      value = Hash(value)

      value = value.map do |k, v|
        "#{k}#{Humanizer.config.key_val_delimeter} #{v}"
      end

      value.join("#{Humanizer.config.hash_delimeter} ")
    end

    def method_missing(name, *args)
      args[0]
    end
  end
end
