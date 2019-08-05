# frozen_string_literal: true

# author Brovkin Oleg
# 04.08.2019

require_relative 'route_class.rb'
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
    @number = number.to_s
    @type = type.to_s
    @speed = 0
    @wagons = wagons.to_i
  end

  def route_set(route)
    # @route = Array.new(route.stations_list)
    @route = route.stations_list
    @station_number = 0
  end

  def speed_set(speed)
    @speed = speed.to_i
  end

  def increment_wagons
    @wagons += 1 if @speed.zero?
  end

  def decrement_wagons
    @wagons -= 1 if @wagons.nonzero? && @speed.zero?
  end

  def next_station_set
    @station_number += 1 if @station_number < (@route.length - 1)
    @station_name = @route[@station_number]
  end

  def prev_station_set
    @station_number -= 1 if @station_number.nonzero?
    @station_name = @route[@station_number]
  end

  # pointer can be in range -N,..0,..+N,
  # so we can ask name of any station in route
  def get_station_name(pointer)
    num = pointer.to_i
    @route[@station_number + num] unless @route[@station_number + num].nil?
  end
end

my_route = Route.new(10, 'First', 100, 'Last')
my_route.add_station(20, 'station_a')
my_route.add_station(30, 'station_b')
my_route.add_station(40, 'station_c')
my_route.add_station(50, 'station_d')
my_route.add_station(60, 'station_e')
# my_route.delete_station('station_c')
puts my_route.stations_list

