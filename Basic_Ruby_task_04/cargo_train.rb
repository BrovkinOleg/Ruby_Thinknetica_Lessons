# frozen_string_literal: true

# author Brovkin Oleg
# 06.08.2019

require_relative 'train'
# new class for cargo train
class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    @type = 'cargo'
    super(number)
  end

  def wagon_add(wagon)
    @wagons << wagon if @speed.zero? && wagon.type == @type
  end
end
