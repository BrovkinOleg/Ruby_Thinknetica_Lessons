# frozen_string_literal: true

# author Brovkin Oleg
# 20.08.2019
require_relative 'card_deck'

class Player
  attr_accessor :player_name
  attr_reader :dollars, :score, :cards
  def initialize
    @dollars = 100
    @cards_all = 0
    @cards = []
    @score = 0
    @player_name = ''
  end

  def ini
    initialize
  end

  def next_play
    @cards = []
    @score = 0
  end

  def dollars_less(sum)
    @dollars -= sum if sum <= @dollars
    @dollars
  end

  def dollars_add(sum)
    @dollars += sum
    @dollars
  end

  def card_get(card)
    @cards << card
    @score += card[:price] unless card[:name] == 'T'
    check = @score + 11 <= 21
    @score += 11 if check && card[:name] == 'T'
    @score += 1 if !check && card[:name] == 'T'
  end

  def fail?
    @score > 21
  end

  def ok?
    @score <= 21
  end

  def number_more?(num)
    @score >= num
  end

  def show_all
    print @player_name.to_s + ': ' + @dollars.to_s + \
          '$, Points = ' + @score.to_s + ', Present cards => '
    @cards.each do |card|
      print card[:name].to_s + card[:mark].to_s + ' '
    end
    puts ''
  end

  def show_stars
    print @player_name.to_s + ': ' + @dollars.to_s + \
          '$, Points = XX, Present cards => '
    @cards.each { print 'XX ' }
    puts ''
  end
end
#====================== check ===============================
# array = CardDeck.new
# array.mix_cards
# # puts array.card_desk_read
# dealer = Player.new
# user = Player.new
# 1.upto(4) { dealer.card_get(array.card_get) }
# 1.upto(4) { user.card_get(array.card_get) }
# dealer.show_all
# user.show_all
# dealer.show_stars
