# frozen_string_literal: true

# author Brovkin Oleg
# 20.08.2019

def user_menu_hint
  puts 'Enter your option number'
  puts '  1: step missing'
  puts '  2: ask for one card'
  puts '  3: open cards'
  puts '  4: next game'
  puts '  0: restart_all'
end

def wrong_hint
  puts 'wrong digit, try again'
  puts ''
end

def user_menu
  user_menu_hint
  loop do
    choice = gets.chomp.to_i
    case choice
    when 1 then dealer_auto_work
    when 2 then user_add_card
    when 3 then open_cards
    when 4 then next_game
    when 0 then restart_game
    else
      wrong_hint
      user_menu_hint
    end
  end
end
