# frozen_string_literal: true

# author Brovkin Oleg
# 04.08.2019
require_relative 'route.rb'
require_relative 'train.rb'
# class Station must get trains by one, returns list of trains,
# can return list of trains by type of train (cargo, passenger),
# can clear train one by one
class Station
  attr_accessor :name, :location
  attr_reader :trains_list

  def initialize(name, location)
    @name = name.capitalize
    @location = location
    @trains_list = []
  end

  def add_train(train)
    @trains_list << train
  end

  def remove_train(train)
    @trains_list[train]&.delete
  end
end

