# frozen_string_literal: true

# author Brovkin Oleg
# 01.08.2019

# must be 10, 15, 20,..100
my_digits = []
(10 / 5..100 / 5).each { |i| my_digits[i - 2] = i * 5 }
print my_digits

