class RPNCalculator
  attr_accessor :value

  def initialize
    @value = 0
    @stack = []
  end

  def push(val)
    @stack.push(val)
  end

  def plus
    do_op :+
  end

  def minus
    do_op :-
  end

  def divide
    do_op :/
  end

  def times
    do_op :*
  end

  def tokens(string)
    operators = ['+', '-', '/', '*']
    string.split.map do |item|
      if operators.include? item then
        item.to_sym
      else
        item.to_numeric
      end
    end
  end

  def evaluate(string)
    operators = {:+ => :plus, :- => :minus, :/ => :divide, :* => :times}
    tokens(string).each do |token|
      token.is_a?(Numeric) ? push(token) : send(operators[token])
    end
    @value
  end

  private

  def do_op(op)
    second = @stack.pop or raise "calculator is empty"
    first = @stack.pop or raise "calculator is empty"
    @value = first.send(op, second.to_f)
    @stack.push(@value)
  end
end

class String
  def to_numeric
    result = self.to_i
    if not result.eql? self
      self.to_f
    else
      result
    end
  end
end