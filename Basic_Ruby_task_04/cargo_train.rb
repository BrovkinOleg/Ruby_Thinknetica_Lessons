# frozen_string_literal: true

# author Brovkin Oleg
# 06.08.2019

require_relative 'train'
# new class for cargo train
class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    @type = 'cargo'
    @number = number
  end

  def wagon_add(wagon)
    @wagons += 1 if @speed.zero? && wagon.type == @type
  end

  private

  # type check for cargo wagon
  def check?(wagon)
    wagon.type == CARGO_TRAIN_TYPE && @speed.zero?
  end
end
