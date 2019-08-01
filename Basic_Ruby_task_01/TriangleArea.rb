# author Brovkin Oleg
# 31.07.2019
puts 'Enter length of the base (cm), please'
length_of_base = gets.chomp
puts 'Enter height of triangle (cm)'
height = gets.chomp
area = height.to_i * length_of_base.to_i / 2

puts "Area of the triangle is #{area}"
