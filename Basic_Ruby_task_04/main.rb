# frozen_string_literal: true

# author Brovkin Oleg
# 06.08.2019
require_relative 'route_menu'
require_relative 'train_menu'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'wagon'

# global arrays for stations, trains, routers
$stations = []
$stations_index = 0
$routes = []
$routes_index = 0
$trains = []
$trains_index = 0

#=== just for test: add stations, routes, trains ===
require_relative 'station_route_train_loads'

def station_instance_add
  stations_list_show
  puts 'tape name of station, please'
  name = gets.chomp
  puts 'tape location \'200\', please'
  location = gets.chomp.to_i
  $stations << Station.new(name, location)
  stations_list_show
  main_menu_hint
end

def station_trains_placed
  trains_list_show
  stations_list_show
  puts 'select station index, please'
  index = gets.chomp.to_i
  output = "trains placed on #{$stations[index].name} => "
  $trains.each do |train|
    if $stations[index].name == train.route.stations_list[train.place_station].name
      output += train.number + ', '
    end
  end
  puts output
end

def main_menu_hint
  puts ''
  puts '=== Main_Menu_Hint ==='
  puts '1 : stations list show'
  puts '2 : routes list show'
  puts '3 : trains list show'
  puts '4 : station instance add'
  puts '5 : route Menu (add, route change, edit stations)'
  puts '6 : train Menu (add, route set, edit wagons)'
  puts '7 : trains placed on station list show'
  puts '10: Main_Menu_Hint'
end

def wrong_hint
  puts 'wrong number, try again'
end

#--------- main_loop ---------------
main_menu_hint
loop do
  choice = gets.chomp.to_i
  case choice
  when 1
    stations_list_show
  when 2
    routes_list_show
  when 3
    trains_list_show
  when 4
    station_instance_add
  when 5
    route_menu
  when 6
    train_menu
  when 7
    station_trains_placed
  when 10
    main_menu_hint
  else
    wrong_hint
    main_menu_hint
  end
end

