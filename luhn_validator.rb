module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)

    # TODO: use the integers in nums_a to validate its last check digit
    check = nums_a.pop
    nums_a.reverse!
    sum = 0
    nums_a.each_with_index do |n, i|
      temp = i.even? ? n * 2 : n
      sum += temp > 9 ? temp % 10 + 1 : temp
    end
    (10 - (sum % 10)).digits[0] == check
  end
end
