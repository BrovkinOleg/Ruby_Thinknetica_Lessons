# frozen_string_literal: true

# author Brovkin Oleg
# 20.08.2019
require_relative 'interface'
class Game
  attr_reader :player, :dealer, :card_deck, :interface

  def initialize(player, dealer, card_deck)
    @player = player
    @dealer = dealer
    @card_deck = card_deck
    @bank = 0
    @result = 0
  end

  def check_bank
    @bank
  end

  def both_fail_or_points_equal
    @player.fail? && @dealer.fail? || \
      @player.points == @dealer.points
  end

  def dealer_fail_or_less_points
    @player.points > @dealer.points && @player.points <= 21 || \
      @player.ok? && @dealer.fail?
  end

  def user_fail_or_less_points
    @player.points < @dealer.points && @dealer.points <= 21 || \
      @player.fail? && @dealer.ok?
  end

  def first_step_two_cards_get
    @card_deck.init_card_deck
    @card_deck.mix_cards
    2.times { @player.card_add(@card_deck.card_get) }
    2.times { @dealer.card_add(@card_deck.card_get) }
    @player.dollars_less(10)
    @dealer.dollars_less(10)
    @bank += 20
  end

  def dealer_card_add
    @dealer.card_add(@card_deck.card_get) unless dealer_seventeen?
  end

  def dealer_seventeen?
    @dealer.points >= 17
  end

  def bank_return
    @dealer.dollars_add(10)
    @player.dollars_add(10)
    @bank = 0
  end

  def dealer_got_money
    @dealer.dollars_add(@bank)
    @bank = 0
  end

  def user_got_money
    @player.dollars_add(@bank)
    @bank = 0
  end

  def user_add_one_card
    @player.card_add(@card_deck.card_get)
  end

  def clean_for_next_round
    @player.clear_cards
    @dealer.clear_cards
    @card_deck.init_card_deck
    @card_deck.mix_cards
  end
end
