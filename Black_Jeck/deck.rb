# frozen_string_literal: true

# author Brovkin Oleg
# 20.08.2019
require_relative 'card'

class Deck
  attr_accessor :cards

  def initialize
    init_card_deck
  end

  def init_card_deck
    @cards = []
    0.upto(3) do |text|
      # 0.upto(Card::NAME.length - 1) do |num|
      Card::NAME.length.times do |num|
        @cards << Card.new(Card::NAME[num], Card::MARK[text], \
                           Card::POINTS[num])
      end
    end
  end

  def mix_cards
    @cards.shuffle!
  end

  def card_get
    @cards.pop if @cards.length.nonzero?
  end
end
#====================== check ===============================
# array = Deck.new
# 0.upto(3) do
#   puts array.card_pull.card_show
#   puts array.cards.length
# end
