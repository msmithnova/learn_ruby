def echo(val)
  val
end

def shout(val)
  val.upcase
end

def repeat(val, num=2)
  ((val + ' ') * num).rstrip
end

def start_of_word(val, num)
  val[0,num]
end

def first_word(val)
  (val.split)[0]
end

def titleize(val)
  little = ['and', 'it', 'the', 'over']
  val.split.each_with_index{|word, index| word.capitalize! unless little.include? word and index != 0}.join(' ')
end