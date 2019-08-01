# author Brovkin Oleg
# 31.07.2019
puts 'Enter your name, please'
name = gets.chomp.capitalize
puts 'Enter your height, please'
height = gets.chomp
weight = height.to_i - 110
if weight < 0
  puts 'You have the optimal weight'
else
  puts "#{name}, your weight must be #{weight}"
end
