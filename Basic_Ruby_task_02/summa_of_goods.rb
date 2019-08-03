# frozen_string_literal: true

# author Brovkin Oleg
# 03.08.2019

basket = {} # hash for goods
loop do
  puts 'Input name of goods, please' # may be "stop"
  name = gets.chomp.to_s.downcase
  break if name == 'stop'

  puts 'Enter price, please'
  price = gets.chomp.to_s
  puts 'Enter amount of goods, please'
  amount = gets.chomp.to_i
  basket[name] = { price => amount }
end
must_pay = 0.0
basket.each_value do |value|
  value.each do |item, quantity|
    must_pay += item.to_f * quantity
  end
end
p basket
p "You must pay #{must_pay}"
