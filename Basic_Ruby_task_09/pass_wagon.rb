# frozen_string_literal: true

# author Brovkin Oleg
# 06.08.2019

require_relative 'wagon'
# this class have type ('pass', 'cargo')and 'weight'
# for pass train
class PassWagon < Wagon
  def one_seat_take
    @busy += 1 if @busy < @number
  end

  def free
    @number - @busy
  end
end
