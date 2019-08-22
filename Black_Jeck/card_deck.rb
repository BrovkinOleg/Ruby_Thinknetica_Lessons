# frozen_string_literal: true

# author Brovkin Oleg
# 20.08.2019
require_relative 'card'

class CardDeck
  NAME = %w[2 3 4 5 6 7 8 9 10 V D K T].freeze
  MARK = %w[+ <3 ^ <>].freeze
  POINTS = %w[2 3 4 5 6 7 8 9 10 10 10 10 11].freeze

  attr_accessor :cards

  def initialize
    init_card_deck
  end

  def init_card_deck
    @cards = []
    0.upto(3) do |text|
      0.upto(NAME.length - 1) do |num|
        @cards << Card.new(NAME[num], MARK[text], POINTS[num])
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
# array = CardDeck.new
# 0.upto(3) do
#   puts array.card_pull.card_show
#   puts array.cards.length
# end
