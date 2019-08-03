# frozen_string_literal: true

# author Brovkin Oleg
# 02.08.2019

vowels_array = %w[a e i o u y]
all_words_array = ('a'..'z').to_a.sort
p all_words_array
p vowels_array
my_hash = {}
vow_index = 0
all_words_array.each_index do |i|
  letter = all_words_array[i]
  if letter == vowels_array[vow_index]
    my_hash[letter.to_s] = i.to_int
    vow_index += 1
  end
end
p my_hash
