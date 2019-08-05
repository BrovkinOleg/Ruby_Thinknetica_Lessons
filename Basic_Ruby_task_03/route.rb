# frozen_string_literal: true

# author Brovkin Oleg
# 03.08.2019

# class Router set first and last station on create instance
# can add, delete middle stations
# can return list of the stations from first to last
class Route
  attr_reader :stations_list

  def initialize(first_station, last_station)
    @stations_list = [first_station, last_station]
  end

  def add_station(name)
    @stations_list << name
  end

  def delete_station(name)
    @stations_list[name]&.delete
  end
end

