# frozen_string_literal: true

# author Brovkin Oleg
# 04.08.2019
require_relative 'instance_counter'

# class Station must get trains by one, returns list of trains,
# can return list of trains by type of train (cargo, passenger),
# can clear train one by one
class Station
  include InstanceCounter

  attr_accessor :name, :location
  attr_reader :trains_list, :stations_counter
  @@stations_all = []

  def self.all
    @@stations_all
  end

  def initialize(name, location)
    @name = name.capitalize
    @location = location
    @trains_list = []
    @stations_counter = 0
    @@stations_all << self
    register_instance
  end

  def add_train(train)
    @trains_list << train
  end

  def remove_train(train)
    @trains_list[train]&.delete
  end

  def trains_type_list(type)
    trains_type = []
    @trains_list.each do |train|
      trains_type << train if train.type == type
    end
    trains_type
  end
end
