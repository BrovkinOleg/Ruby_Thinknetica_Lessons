# frozen_string_literal: true

# author Brovkin Oleg
# 20.08.2019
require_relative 'player'
require_relative 'deck'
require_relative 'interface'
require_relative 'main'
require_relative 'game'

class BlackJeck
  def initialize
    player = Player.new
    dealer = Player.new
    card_deck = Deck.new
    game = Game.new(player, dealer, card_deck)
    interface = Interface.new(game)
    main = Main.new(interface)
    main.main_menu
  end
end
#==================== check =====================
BlackJeck.new
