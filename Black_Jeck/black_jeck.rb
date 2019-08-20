# frozen_string_literal: true

# author Brovkin Oleg
# 20.08.2019
require_relative 'player'

class BlackJeck
  attr_reader :player

  def initialize
    @player = Player.new
    @dealer = Player.new
    @card_deck = CardDeck.new
    @bank = 0
    @result = 0
  end

  load('menu.rb')

  def first_step_two_cards_get
    @card_deck.init_card_deck
    @card_deck.mix_cards
    2.times { @player.card_get(@card_deck.card_get) }
    2.times { @dealer.card_get(@card_deck.card_get) }
    @player.dollars_less(10)
    @dealer.dollars_less(10)
    show_user_and_stars
    @bank += 20
  end

  def show_user_and_dealer
    @player.show_all
    @dealer.show_all
  end

  def check_results
    @result = 1 if @player.score < @dealer.score
    @result = 2 if @player.score > @dealer.score
    @result = 3 if @player.score == @dealer.score
    @result = 4 if @player.ok? && @dealer.fail?
    @result = 5 if @player.fail? && @dealer.ok?
    @result = 6 if @player.fail? && @dealer.fail?
  end

  def money_back
    puts ' return money form bank '
    @dealer.dollars_add(10)
    @player.dollars_add(10)
    @bank = 0
  end

  def user_loss_money
    puts ' user loss money '
    @dealer.dollars_add(@bank)
    @bank = 0
  end

  def user_win_money
    puts ' user_win_money '
    @player.dollars_add(@bank)
    @bank = 0
  end

  def show_result
    check_results
    puts 'That\'s all, look at your cards, please'
    choice = @result
    case choice
    when 6, 3 then money_back
    when 5, 1 then user_loss_money
    when 4, 2 then user_win_money
    else
      puts "result is #{@result}"
    end
  end

  def show_user_and_stars
    @player.show_all
    @dealer.show_stars
  end

  def start_menu
    puts 'Enter your name, please' if @player.player_name == ''
    @player.player_name = gets.chomp.capitalize
    @dealer.player_name = 'Jeck'
    puts 'Let\'s start a game. Look at your two cards:'
    sleep(1)
    first_step_two_cards_get
    user_menu
  end
end
#==================== check =====================
q = BlackJeck.new
q.start_menu
