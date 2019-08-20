# frozen_string_literal: true

# author Brovkin Oleg
# 20.08.2019
class CardDeck
  attr_reader :cards_left
  def initialize
    @card_deck = []
    @cards_left = 52
    @card = {}
    init_card_deck
  end

  def init_card_deck
    @card_deck = []
    name = %w[2 3 4 5 6 7 8 9 10 V D K T]
    price = %w[2 3 4 5 6 7 8 9 10 10 10 10 11]
    # mark = %w[spades clubs hearts diamonds]
    mark = %w[+ <3 ^ <>]
    0.upto(3) do |text|
      0.upto(name.length - 1) do |num|
        @card_deck << { name: name[num].to_sym, mark: mark[text].to_sym, \
                        price: price[num].to_i }
      end
    end
  end

  def card_desk_read
    @card_deck
  end

  def mix_cards
    cards = @card_deck.length
    @card_deck.shuffle! if cards == 52
    # ('A'..'Z').to_a.shuffle! if cards == 52
  end

  def cards_zero?
    @card_deck.length.zero?
  end

  def card_get
    out = @card_deck.last
    @card_deck.pop.compact! unless @card_deck.length.zero?
    @cards_left = @card_deck.length
    out
  end
end
#====================== check ===============================
# array = CardDeck.new
# array.mix_cards
# puts array.card_desk_read
