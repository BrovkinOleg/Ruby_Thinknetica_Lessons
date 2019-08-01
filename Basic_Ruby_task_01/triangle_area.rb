# frozen_string_literal: true

# author Brovkin Oleg
# 31.07.2019
puts 'Enter length of the base (cm), please'
length_of_base = gets.chomp.to_i
puts 'Enter height of triangle (cm)'
height = gets.chomp.to_i
area = height * length_of_base / 2

puts "Area of the triangle is #{area}"
