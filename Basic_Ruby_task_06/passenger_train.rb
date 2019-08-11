# frozen_string_literal: true

# author Brovkin Oleg
# 06.08.2019

require_relative 'train'

# new class for passenger_train
class PassengerTrain < Train

  attr_reader :number, :trains_counter

  def initialize(number)
    @type = 'pass'
    super
    @trains_counter = 0
    register_instance
  end

  def wagon_add(wagon)
    @wagons << wagon if @speed.zero? && wagon.type == @type
  end
end
