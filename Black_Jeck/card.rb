# frozen_string_literal: true

# author Brovkin Oleg
# 21.08.2019
class Card
  attr_accessor :name, :mark, :points

  def initialize(name, mark, points)
    @name = name
    @mark = mark
    @points = points.to_i
  end

  def card_show
    "#{@name}_#{mark} #{points}"
  end
end
