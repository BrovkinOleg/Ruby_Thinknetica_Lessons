# frozen_string_literal: true

# author Brovkin Oleg
# 21.08.2019
class Card
  attr_accessor :name, :mark, :points

  NAME = %w[2 3 4 5 6 7 8 9 10 V D K T].freeze
  MARK = %w[+ <3 ^ <>].freeze
  POINTS = %w[2 3 4 5 6 7 8 9 10 10 10 10 11].freeze

  def initialize(name, mark, points)
    @name = name
    @mark = mark
    @points = points.to_i
  end

  def card_show
    "#{@name}_#{mark} #{points}"
  end
end
