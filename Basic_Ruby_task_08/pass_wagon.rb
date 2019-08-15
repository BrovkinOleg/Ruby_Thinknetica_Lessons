# frozen_string_literal: true

# author Brovkin Oleg
# 06.08.2019

require_relative 'wagon'
# this class have type ('pass', 'cargo')and 'weight'
# for pass train
class PassWagon < Wagon
  attr_reader :seats_amount, :busy

  def initialize(seats_amount)
    @seats_amount = seats_amount
    @busy = 0
  end

  def one_seat_take
    @busy += 1 if @busy < @seats_amount
  end

  def busy_set(busy)
    @busy = busy if busy <= @seats_amount
  end

  def free
    @seats_amount - @busy
  end
end
