# frozen_string_literal: true

# author Brovkin Oleg
# 20.08.2019
require_relative 'messages'
class Game
  include Messages
  attr_reader :player, :dealer, :card_deck
  def initialize(player, dealer, card_deck)
    @player = player
    @dealer = dealer
    @card_deck = card_deck
    @bank = 0
    @result = 0
  end

  def show_user_and_dealer
    show_cards(@player)
    show_cards(@dealer)
  end

  def show_user_and_stars
    show_cards(@player)
    show_stars(@dealer)
  end

  def show_result
    check_results
    choice = @result
    case choice
    when 6, 3 then money_back
    when 5, 1 then user_loss_money
    when 4, 2 then user_win_money
    else
      result_message(@result)
    end
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

  def first_step_two_cards_get
    @card_deck.init_card_deck
    @card_deck.mix_cards
    2.times { @player.card_add(@card_deck.card_get) }
    2.times { @dealer.card_add(@card_deck.card_get) }
    @player.dollars_less(10)
    @dealer.dollars_less(10)
    show_user_and_stars
    @bank += 20
  end

  def dealer_auto_work
    sleep(1)
    step_missing(@dealer.name) if @dealer.points > 17
    @dealer.card_add(@card_deck.card_get) unless @dealer.points > 17
    show_user_and_stars
    your_turn(@player)
    game_menu_hint
  end

  def check_results
    @result = 1 if @player.points < @dealer.points
    @result = 2 if @player.points > @dealer.points
    @result = 3 if @player.points == @dealer.points
    @result = 4 if @player.ok? && @dealer.fail?
    @result = 5 if @player.fail? && @dealer.ok?
    @result = 6 if @player.fail? && @dealer.fail?
  end

  def money_back
    return_money
    @dealer.dollars_add(10)
    @player.dollars_add(10)
    @bank = 0
  end

  def user_loss_money
    looser
    @dealer.dollars_add(@bank)
    @bank = 0
  end

  def user_win_money
    winner
    @player.dollars_add(@bank)
    @bank = 0
  end

  def user_add_card
    @player.card_add(@card_deck.card_get)
    show_user_and_stars
    sleep(1)
    game_menu_hint
  end

  def open_cards
    show_result
    show_user_and_dealer
    sleep(1)
    start_next_round
    game_menu_hint
  end

  def next_game
    money_back if @bank.nonzero?
    @player.clear_cards
    @dealer.clear_cards
    @card_deck.init_card_deck
    @card_deck.mix_cards
    start_new_game_message
    sleep(1)
    first_step_two_cards_get
    game_menu_hint
  end
end
