# frozen_string_literal: true

# author Brovkin Oleg
# 03.08.2019

# class Router set first and last station on create instance
# can add, delete middle stations
# can return list of the stations from first to last
class Route
  attr_reader :station_list

  def initialize(first_place, first_name, last_place, last_name)
    @last_place = last_place
    @station_list = { first_place => first_name.to_s.capitalize,
                      last_place => last_name.to_s.capitalize }
  end

  # if 'place' exists - change 'name', else add 'name' to route
  def add_station(place, name)
    @station_list[place] = name.to_s.capitalize
    @station_list.sort_by { |distance, _station| distance }
  end

  def delete_station(name)
    @station_list.delete_if do |_key, value|
      value == name.to_s.capitalize
    end
  end

  def stations_list
    @station_list = @station_list.sort.to_h
    @station_list.each_value.to_a
  end
end

