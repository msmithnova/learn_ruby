module InWords
  def in_words
    high = ['trillion', 'billion', 'million', 'thousand', nil]
    return "zero" if self == 0
    result = []
    num = ("%015d" % self).to_s.scan(/\d{1,3}/).map {|n| n.to_i}
    num.each_with_index do |n, index|
      if n > 0 then
        result += process_section(n).split
        suffix = high[index]
        result << suffix if suffix
      end
    end
    result.join(' ')
  end

  private

  def process_section(num)
    singles = %w(zero one two three four five six seven eight nine)
    teens = %w(ten eleven twelve thir four fif six seven eigh nine)
    tens = %w(twenty thirty forty fifty sixty seventy eighty ninety)

    case num
    when 0
      ''
    when (1..9)
      singles[num]
    when (10..12)
      teens[num - 10]
    when (13..19)
      teens[num - 10] + 'teen'
    when (20..99)
      result = tens[num / 10 - 2]
      mod = num % 10
      mod == 0 ? result : result + ' ' + singles[mod]
    else
      result = singles[num / 100]
      result << ' hundred '
      result << process_section(num % 100)
    end
  end
end

class Fixnum
  include InWords
end

class Bignum
  include InWords
end