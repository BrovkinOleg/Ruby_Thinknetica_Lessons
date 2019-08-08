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

  def add_station(station)
    @stations_list << station
    stations_list_sort
  end

  def delete_station(index)
    @stations_list.delete_at(index) if @stations_list.length > 2
    stations_list_sort
  end

  def stations_list_sort
    # @stations_list.sort_by { |station| station.location }
    @stations_list = @stations_list.sort_by(&:location)
  end

  def first_last_name
    @stations_list.first.name.to_s \
    + '-' + @stations_list.last.name.to_s
  end
end


