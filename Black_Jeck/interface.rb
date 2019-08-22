# frozen_string_literal: true

# author Brovkin Oleg
# 20.08.2019
class Interface
  attr_accessor :game

  def initialize(game)
    @game = game
  end

  def getter_digit
    gets.chomp.to_i
  end

  def getter_string
    gets.chomp.capitalize
  end

  def main_menu_hint
    puts 'Enter your option number'
    puts '  1: start new game'
    puts '  2: repeat this menu'
    puts '  3: exit program'
    puts ''
  end

  def game_menu_hint
    puts 'Enter your option number'
    puts '  1: next game round '
    puts '  2: ask for one card'
    puts '  3: step missing'
    puts '  4: open cards'
    puts '  5: this menu show'
    puts '  0: exit to main menu'
    puts ''
  end

  def wrong_hint
    puts 'Wrong digit, try again'
    puts ''
  end

  def winner
    puts '=== Player win. Congratulations ==='
  end

  def looser
    puts '=== you loose money. Sorry ==='
  end

  def look_at_your_cards
    puts 'That\'s all, look at your cards, please'
  end

  def step_missing(name)
    puts "#{name} ==> missing step"
  end

  def your_turn(name)
    puts name.name.capitalize.to_s + ', ... Your turn'
  end

  def result_message(result)
    puts "result is #{result}"
  end

  def return_money
    puts 'Return money from bank '
  end

  def start_new_game_message
    puts 'Let\'s start a game. Look at your two cards:'
  end

  def enter_your_name
    puts 'Enter your name, please'
  end

  def see_you_later
    puts '..See you later..'
  end

  def start_next_round
    puts 'Enter \'1\' to start next round of game'
    puts ''
  end

  def show_cards(gamer)
    text = "#{gamer.name}: #{gamer.dollars}$, Points= #{gamer.points}, cards= "
    gamer.cards.each do |card|
      text += "#{card.name}#{card.mark} "
    end
    puts text.to_s
  end

  def show_stars(gamer)
    text = "#{gamer.name}: #{gamer.dollars}$, Points= XX, cards= "
    gamer.cards.each { text += 'XX ' }
    puts text.to_s
  end
end
