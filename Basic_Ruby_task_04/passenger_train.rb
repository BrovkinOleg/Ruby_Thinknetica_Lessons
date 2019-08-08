# frozen_string_literal: true

# author Brovkin Oleg
# 06.08.2019

require_relative 'train'
# new class for passenger_train
class PassengerTrain < Train
  attr_reader :type, :number

  def initialize(number)
    @type = 'pass'
    super(number)
  end

  def wagon_add(wagon)
    @wagons += 1 if @speed.zero? && wagon.type == @type
  end

  private

  # type check for pass wagon
  def check?(wagon)
    wagon.type == PASS_TRAIN_TYPE && @speed.zero?
  end
end
