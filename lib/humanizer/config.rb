module Humanizer
  class Config
    attr_accessor :array_delimeter, :hash_delimeter, :key_val_delimeter

    def initialize
      @hash_delimeter = ','
      @array_delimeter = ','
      @key_val_delimeter = ':'
    end
  end
end