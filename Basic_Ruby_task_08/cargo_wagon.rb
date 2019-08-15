# frozen_string_literal: true

# author Brovkin Oleg
# 06.08.2019

require_relative 'wagon'
# this class have type ('pass', 'cargo')and 'weight'
# for cargo train
class CargoWagon < Wagon
  attr_reader :volume, :busy

  def initialize(volume)
    @volume = volume
    @busy = 0
  end

  def free_volume
    @volume - @busy
  end

  def busy_set(busy)
    @busy = busy if busy <= @volume
  end
end
