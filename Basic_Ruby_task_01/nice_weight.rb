# frozen_string_literal: true

# author Brovkin Oleg
# 31.07.2019
puts 'Enter your name, please'
name = gets.chomp.capitalize
puts 'Enter your height, please'
height = gets.chomp.to_i
weight = height - 110
if weight.negative?
  puts 'You have the optimal weight'
else
  puts "#{name}, your weight must be #{weight}"
end
