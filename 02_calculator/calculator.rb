def add(val1, val2)
  val1 + val2
end

def subtract(val1, val2)
  val1 - val2
end

def sum(arr)
  arr.inject(0, :+)
end

def multiply(arr)
  arr.inject(1, :*)
end

def power(val1, val2)
  val1 ** val2
end

def factorial(val)
  return 1 if val == 0 or val ==1
  multiply((1..val).to_a)
end