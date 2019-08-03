# frozen_string_literal: true

# author Brovkin Oleg
# 02.08.2019

# must_be 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233,..
# F[n] = F[n - 1] + F[n - 2]

fibonacci = [0, 1]
loop do
  last_number = fibonacci.length
  next_fibonacci = fibonacci.last + fibonacci[last_number - 2]
  break if next_fibonacci > 100

  fibonacci.push(next_fibonacci)
end
puts fibonacci


