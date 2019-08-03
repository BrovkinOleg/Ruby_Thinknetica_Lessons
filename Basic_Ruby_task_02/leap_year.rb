# frozen_string_literal: true

# author Brovkin Oleg
# 01.08.2019

puts 'Enter number of day, please'
input_day = gets.chomp.to_i
puts 'Enter number of month, please'
input_month = gets.chomp.to_i
puts 'Enter number of year, please'
input_year = gets.chomp.to_i

number_of_days = {
  1 => 31, 2 => 28, 3 => 31, 4 => 30, # 2 => 29
  5 => 31, 6 => 30, 7 => 31, 8 => 31,
  9 => 30, 10 => 31, 11 => 30, 12 => 31
}

if ((input_year % 4).zero? && (input_year % 100) != 0) \
  || (input_year % 400).zero?

  number_of_days[2] = 29
  puts 'This is leap year'
end

sum_of_days = input_day
number_of_days.each do |index, value|
  break if index == input_month

  sum_of_days += value
end
p sum_of_days
