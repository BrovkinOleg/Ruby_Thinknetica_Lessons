# frozen_string_literal: true

# author Brovkin Oleg
# 01.08.2019
days = {
  January: 31,
  February: 28,
  March: 31,
  April: 30,
  May: 31,
  June: 30,
  July: 31,
  August: 31,
  September: 30,
  October: 31,
  November: 30,
  December: 31
}

days.each do |val, index|
  puts val if index == 30
end
