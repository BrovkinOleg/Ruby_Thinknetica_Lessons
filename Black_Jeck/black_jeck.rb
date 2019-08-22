# frozen_string_literal: true

# author Brovkin Oleg
# 20.08.2019
require_relative 'player'
require_relative 'card_deck'
require_relative 'game_interface'
require_relative 'main_interface'
require_relative 'game'

class BlackJeck
  def initialize
    player = Player.new
    dealer = Player.new
    card_deck = CardDeck.new
    game = Game.new(player, dealer, card_deck)
    game_interface = GameInterface.new(game)
    main_interface = MainInterface.new(game, game_interface)
    main_interface.main_menu
  end
end
#==================== check =====================
BlackJeck.new
