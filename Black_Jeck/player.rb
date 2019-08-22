# frozen_string_literal: true

# author Brovkin Oleg
# 20.08.2019
require_relative 'card_deck'

class Player
  attr_accessor :name
  attr_reader :dollars, :points, :cards
  def initialize
    @name = ''
    @cards = []
    @points = 0
    @dollars = 100
  end

  def init
    initialize
  end

  def clear_cards
    @cards = []
    @points = 0
  end

  def dollars_less(sum)
    @dollars -= sum if sum <= @dollars
  end

  def dollars_add(sum)
    @dollars += sum
  end

  def card_add(card)
    @cards << card
    @points += card.points unless card.name == 'T'
    return unless card.name == 'T'

    @points += @points + 11 <= 21 ? 11 : 1
  end

  def fail?
    @points > 21
  end

  def ok?
    @points <= 21
  end
end
#====================== check ===============================
# array = CardDeck.new
# dealer = Player.new('Jeck')
# user = Player.new('Oleg')
# 1.upto(4) { dealer.card_add(array.card_pull) }
# 1.upto(4) { user.card_add(array.card_pull) }
