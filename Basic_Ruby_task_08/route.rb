# frozen_string_literal: true

# author Brovkin Oleg
# 03.08.2019
require_relative 'valid'
require_relative 'instance_counter'

# class Router set first and last station on create instance
# can add, delete middle stations
# can return list of the stations from first to last
class Route
  include InstanceCounter
  include Valid

  STATION = /^[A-Z][a-z]{2,14}$/

  attr_reader :stations_list, :routes_counter,
              :first_station, :last_station

  def initialize(first_station, last_station)
    @stations_list = [first_station, last_station]
    @routes_counter = 0
    @first_station = first_station
    @last_station = last_station
    validate!
    register_instance
  end

  def add_station(station)
    @stations_list << station
    stations_list_sort
  end

  def delete_station(index)
    @stations_list.delete_at(index) if @stations_list.length > 2
    stations_list_sort
  end

  def stations_list_sort
    @stations_list = @stations_list.sort_by(&:location)
  end

  def first_last_name
    @stations_list.first.name.to_s \
    + '-' + @stations_list.last.name.to_s
  end

  protected

  def validate!
    raise 'First Station looks: \'Moscow\'' if first_station.name !~ STATION
    raise 'Last Station looks: \'Tula\'' if last_station.name !~ STATION
    # raise 'Station must be different'\
    #       if first_station.name == last_station.name

  end
end