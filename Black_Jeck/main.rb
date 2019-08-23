# frozen_string_literal: true

# author Brovkin Oleg
# 20.08.2019
# require_relative 'game_interface'
# require_relative 'interface'
class Main
  DEALER_NAME = 'Jeck'

  def initialize(interface)
    @interface = interface
    @game = interface.game
    @player = interface.game.player
    @dealer = interface.game.dealer
    @card_deck = interface.game.card_deck
  end

  def main_menu
    @interface.main_menu_hint
    loop do
      choice = @interface.getter_digit
      case choice
      when 1 then start_new_game
      when 2 then @interface.main_menu_hint
      when 3
        @interface.see_you_later
        break
      else
        @interface.wrong_hint
        @interface.main_menu_hint
      end
    end
  end

  def start_new_game
    @interface.enter_your_name
    @game.player.init
    @game.dealer.init
    @game.player.name = @interface.getter_string
    @game.dealer.name = DEALER_NAME
    @game.card_deck.init_card_deck
    @game.card_deck.mix_cards
    @interface.start_new_game_message
    sleep(1)
    game_menu
  end

  def game_menu
    @game.first_step_two_cards_get
    show_user_and_stars
    @interface.game_menu_hint
    loop do
      choice = @interface.getter_digit
      case choice
      when 1 then user_add_card
      when 2 then dealer_auto_work
      when 3
        if open_cards == 1
          next_game
        else
          @interface.main_menu_hint
          break
        end
      when 4 then @interface.game_menu_hint
      when 0
        @interface.main_menu_hint
        break
      else
        @interface.wrong_hint
        @interface.game_menu_hint
      end
    end
  end

  def show_user_and_dealer
    @interface.show_cards(@player)
    @interface.show_cards(@dealer)
  end

  def show_user_and_stars
    @interface.show_cards(@player)
    @interface.show_stars(@dealer)
  end

  def next_game
    money_back if @game.check_bank.nonzero?
    @game.clean_for_next_round
    @interface.start_new_game_message
    sleep(1)
    @game.first_step_two_cards_get
    show_user_and_stars
    @interface.game_menu_hint
  end

  def open_cards
    result_calculation
    show_user_and_dealer
    sleep(1)
    @interface.start_next_round
    @interface.getter_digit
  end

  def result_calculation
    money_back if @game.both_fail_or_points_equal
    user_win_money if @game.dealer_fail_or_less_points
    user_loss_money if @game.user_fail_or_less_points
  end

  def user_add_card
    @game.user_add_one_card
    show_user_and_stars
    sleep(1)
    @interface.game_menu_hint
  end

  def user_win_money
    @interface.winner
    @game.user_got_money
  end

  def user_loss_money
    @interface.looser
    @game.dealer_got_money
  end

  def money_back
    @interface.return_money
    @game.bank_return
  end

  def dealer_auto_work
    sleep(1)
    @interface.step_missing(@dealer.name) if @game.dealer_seventeen?
    @game.dealer_card_add
    show_user_and_stars
    @interface.your_turn(@player)
    @interface.game_menu_hint
  end

  def first_step
    @game.first_step_two_cards_get
    show_user_and_stars
  end
end
