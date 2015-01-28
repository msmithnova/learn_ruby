def translate(words)
  vowels = 'aeiouAEIOU'.split('')
  words.split.map do |word|
    while not vowels.include? word[0]
      if word[0, 2] == "qu" then
        word = word[2, word.length] + word[0, 2]
      else
        word = word[1, word.length] + word[0]
      end
    end
    word = word + "ay"
  end.join(' ')
end