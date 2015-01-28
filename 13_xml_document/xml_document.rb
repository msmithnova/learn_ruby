class XmlDocument
  def initialize(indent=false)
    @indent = indent
    @level = 0
  end

  def method_missing(m, *args, &block)
    hash = args.inject { |a, b| a.merge(b) }
    attribs = hash.map { |key, value| key.to_s + "='" + value +"'" }.join(',') unless hash == nil
    if block then
      @level += 1 if @indent
      inner = yield
      if @indent then
        inner = "\n#{'  '  * @level}#{inner}\n#{'  '  * (@level - 1)}"
      end
      @level -= 1 if @indent
    end
    if inner then
      if hash == nil then
        result = "<#{m}>#{inner}</#{m}>"
      else
        result = "<#{m} #{attribs}>#{inner}</#{m}>"
      end
      result += "\n" if @indent and @level == 0
    else
      if hash == nil then
        result = "<#{m}/>"
      else
        result = "<#{m} #{attribs}/>"
      end
    end
    result
  end
end