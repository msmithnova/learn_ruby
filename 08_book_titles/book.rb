class Book
  attr_accessor :title

  def title=(title)
    conjunctions = ['for', 'and', 'nor', 'but', 'or', 'yet', 'so']
    prepositions = ['at', 'to', 'in', 'on', 'up', 'of']
    articles = ['the', 'a', 'an']
    except = conjunctions + prepositions + articles
    @title = title.split.each_with_index{ |word, index| word.capitalize! unless except.include? word and index != 0}.join(' ')
  end
end