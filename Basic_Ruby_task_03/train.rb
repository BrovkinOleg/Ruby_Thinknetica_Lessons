# frozen_string_literal: true

# author Brovkin Oleg
# 04.08.2019

require_relative 'route.rb'
# class Train must get name, type(cargo, passenger), count of wagons
# can change velocity, return velocity, return number of wagons,
# can change number of wagons if velocity.zero? == true
# can get route (class) => and after so puts on the first station of route
# can move between stations on the route force and back only by one station
# can return name of the station with reference to current station
class Train
  # attr_accessor :speed
  attr_reader :number, :type, :wagons, :route, :speed,
              :station_name, :station_number

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @speed = 0
    @wagons = wagons
  end

  def route_set(route)
    @route = route
    @station_number = 0
  end

  def speed_set(speed)
    @speed = speed
  end

  def increment_wagons
    @wagons += 1 if @speed.zero?
  end

  def decrement_wagons
    @wagons -= 1 if @wagons.nonzero? && @speed.zero?
  end

  def next_station_set
    @station_number += 1 if @station_number < (@route.length - 1)
  end

  def prev_station_set
    @station_number -= 1 if @station_number.nonzero?
  end

  def current_station_name
    @route.stations_list[@station_number].name
  end

  def next_station_name
    @route.stations_list[@station_number + 1].name
  end

  def prev_station_name
    @route.stations_list[@station_number - 1].name
  end
end

