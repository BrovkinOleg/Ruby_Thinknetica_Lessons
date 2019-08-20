# frozen_string_literal: true
# author Brovkin Oleg
# 20.08.2019
require_relative 'black_jeck'

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

def dealer_auto_work
  sleep(1)
  puts 'Dealer ==> Step missing' if @dealer.number_more?(17)
  @dealer.card_get(@card_deck.card_get) unless @dealer.number_more?(17)
  show_user_and_stars
  puts @player.player_name.to_s + ', ... Your turn'
  user_menu_hint
end

def user_add_card
  @player.card_get(@card_deck.card_get)
  show_user_and_stars
  sleep(1)
  user_menu_hint
end

def open_cards
  show_result
  show_user_and_dealer
  sleep(1)
  puts ''
  next_game
end

def next_game
  @player.next_play
  @dealer.next_play
  puts 'Let\'s start a game. Look at your two cards:'
  sleep(1)
  first_step_two_cards_get
  user_menu_hint
end

def restart_game
  @player.ini
  @dealer.ini
  puts 'Enter your name, please' if @player.player_name == ''
  @player.player_name = gets.chomp.capitalize
  @dealer.player_name = 'Jeck'
  puts 'Let\'s start a game. Look at your two cards:'
  sleep(1)
  first_step_two_cards_get
  user_menu_hint
end
