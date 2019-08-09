# frozen_string_literal: true

# author Brovkin Oleg
# 04.08.2019

require_relative 'route'
# class Train must get name, type(cargo, passenger), count of wagons
# can change velocity, return velocity, return number of wagons,
# can change number of wagons if velocity.zero? == true
# can get route (class) => and after so puts on the first station of route
# can move between stations on the route force and back only by one station
# can return name of the station with reference to current station
class Train
  attr_accessor :speed, :place_station
  attr_reader :number, :route, :wagons

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
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

  private

  def first_station?
    @place_station.zero?
  end

  def last_station?
    @place_station == @route.stations_list.length - 1
  end
end

