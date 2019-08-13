# frozen_string_literal: true

# author Brovkin Oleg
# 06.08.2019

require_relative 'train'
# new class for cargo train
class CargoTrain < Train

  attr_reader :type, :trains_counter

  def initialize(number)
    super
    @trains_counter = 0
    register_instance
  end

  def wagon_add(wagon)
    @wagons << wagon if @speed.zero?
  end
end
