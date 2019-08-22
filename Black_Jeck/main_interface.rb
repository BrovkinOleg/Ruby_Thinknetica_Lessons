# frozen_string_literal: true

# author Brovkin Oleg
# 20.08.2019
require_relative 'game_interface'
require_relative 'messages'
class MainInterface
  include Messages

  DEALER_NAME = 'Jeck'

  def initialize(game, game_interface)
    @game = game
    @game_interface = game_interface
  end

  def main_menu
    main_menu_hint
    loop do
      choice = gets.chomp.to_i
      case choice
      when 1 then start_new_game
      when 2 then main_menu_hint
      when 3
        see_you_later
        break
      else
        wrong_hint
        main_menu_hint
      end
    end
  end

  def start_new_game
    enter_your_name if @game.player.name == ''
    @game.player.init
    @game.dealer.init
    @game.player.name = gets.chomp.capitalize
    @game.dealer.name = DEALER_NAME
    @game.card_deck.init_card_deck
    @game.card_deck.mix_cards
    start_new_game_message
    sleep(1)
    @game_interface.game_menu
  end
end
