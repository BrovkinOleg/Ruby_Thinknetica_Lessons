# author Brovkin Oleg
# 31.07.2019
puts 'Enter parameter \"a\", please'
a = gets.chomp.to_i
puts 'Enter parameter \"b\", please'
b = gets.chomp.to_i
puts 'Enter parameter \"c\", please'
c = gets.chomp.to_i

D = (b * b - 4 * a * c) / 2

if D >= 0
  root_of_d = Math.sqrt(D)
else
  root_of_d = 0
end

X1 = (-b + root_of_d) / 2
X2 = (-b - root_of_d) / 2

if D.positive?
  puts "X1 = #{X1}, X2 = #{X2}"
elsif D.zero?
  puts "D == 0, so X1 = X2 = #{X1}"
else
  puts 'D < 0, no solutions'
end




