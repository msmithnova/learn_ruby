class Temperature
  def initialize(options)
    @fahrenheit = options[:f]
    @celsius = options[:c]
  end

  def in_fahrenheit
    @fahrenheit or @celsius * 9 / 5.0 + 32
  end

  def in_celsius
    @celsius or (@fahrenheit - 32) * 5 / 9.0
  end

  def self.from_celsius(val)
    self.new(:c => val)
  end

  def self.from_fahrenheit(val)
    self.new(:f => val)
  end
end

class Celsius < Temperature
  def initialize(val)
    @celsius = val
  end
end

class Fahrenheit < Celsius
  def initialize(val)
    @fahrenheit = val
  end
end