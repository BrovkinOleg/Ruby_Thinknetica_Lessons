# author Brovkin Oleg
# 31.07.2019
puts "Enter length of first side (cm), please"
A = gets.chomp.to_i
puts "Enter length of second side (cm), please"
B = gets.chomp.to_i
puts "Enter length of third side (cm), please"
C = gets.chomp.to_i

# The Pythagorean theorem
def apple(a,b,c)
  if a > b && a > c
    a*a == b*b + c*c
  elsif b > a && b > c
    b*b == a*a + c*c
  elsif c > a && c > b
    c*c == a*a + b*b
  else
    false
  end
end

if A == B && B == C
  puts "This is equilateral triangle"
elsif A == B || A == C || B == C
  puts "This is isosceles triangle"
elsif apple(A,B,C)
  puts "This is rectangular triangle"
elsif
  puts "The triangle of the other type"
end


