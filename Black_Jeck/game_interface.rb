# frozen_string_literal: true

# author Brovkin Oleg
# 20.08.2019
require_relative 'Messages'
class GameInterface
  include Messages
  def initialize(game)
    @game = game
    @player = game.player
    @dealer = game.dealer
    @card_deck = game.card_deck
  end

  def game_menu
    @game.first_step_two_cards_get
    game_menu_hint
    loop do
      choice = gets.chomp.to_i
      case choice
      when 1 then @game.next_game
      when 2 then @game.user_add_card
      when 3 then @game.dealer_auto_work
      when 4 then @game.open_cards
      when 5 then game_menu_hint
      when 0
        main_menu_hint
        break
      else
        wrong_hint
        game_menu_hint
      end
    end
  end
end
