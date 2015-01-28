class Dictionary
  attr_accessor :entries

  def initialize
    @entries = {}
  end

  def add(entry)
    entry.is_a?(Hash) ? @entries.merge!(entry) : @entries[entry] = nil
  end

  def keywords
    @entries.keys.sort
  end

  def include?(key)
    self.keywords.include? key
  end

  def find(key)
    keys = self.keywords.collect{|word| word if /^#{key}/.match word}
    result = {}
    keys.each do |k|
      val = @entries[k]
      result[k] = val if val
    end
    result
  end

  def printable
    result = ''
    self.keywords.each { |key| result += %Q{[#{key}] "#{@entries[key]}"\n} }
    result.rstrip
  end
end