# frozen_string_literal: true

# author Brovkin Oleg
# 04.08.2019

require_relative 'valid'
require_relative 'route'
require_relative 'manufacturer'
require_relative 'instance_counter'

# class Train
class Train
  include Manufacturer
  include InstanceCounter
  include Valid

  NUMBER = /^[A-Z]{3}-?\d{2}$/

  attr_accessor :speed, :place_station
  attr_reader :number, :route, :wagons
  @@trains = {}

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    validate!
    @@trains[number] = self
  end

  def self.find(number)
    @@trains[number]
  end

  def wagon_remove
    @wagons.pop if @wagons.length > 1 && @speed.zero?
  end

  def route_set(route)
    @route = route
    @place_station = 0
  end

  def next_station_set
    @place_station += 1 unless last_station?
  end

  def prev_station_set
    @place_station -= 1 unless first_station?
  end

  def current_station_name
    @route.stations_list[@place_station].name
  end

  def next_station_name
    @route.stations_list[@place_station + 1]&.name
  end

  def prev_station_name
    @route.stations_list[@place_station - 1]&.name
  end

  protected

  def validate!
    raise 'Number must look like: \'ABC-12\'' if number !~ NUMBER

  end

  private

  def first_station?
    @place_station.zero?
  end

  def last_station?
    @place_station == @route.stations_list.length - 1
  end
end

