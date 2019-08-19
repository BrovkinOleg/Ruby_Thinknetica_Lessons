# frozen_string_literal: true

# author Brovkin Oleg
# 06.08.2019

require_relative 'train'
# new class for cargo train
class CargoTrain < Train

  # validate :number, :type, CargoTrain

  attr_reader :number, :trains_counter

  def initialize(number)
    super
    @trains_counter = 0
    register_instance
  end

  def cargo_wagon?(wagon)
    wagon.instance_of?(CargoWagon)
  end

  def wagon_add(wagon)
    @wagons << wagon if @speed.zero? && cargo_wagon?(wagon)
  end

  def to_s
    " cargo \"#{number}\"(#{@wagons.length} wagons) "
  end
end
