# frozen_string_literal: true

# author Brovkin Oleg
# 07.08.2019
# require_relative 'route'
# require_relative 'main'

def route_menu_hint
  puts ''
  puts '=== route_Menu_Hint ==='
  routes_list_show
  puts 'current route => ' + $routes[$routes_index].first_last_name
  route_stations_list_show
  puts '1 : add new route'
  puts '2 : select next route in list'
  puts '3 : select prev route in list'
  puts '4 : add station to route'
  puts '5 : remove station from route'
  puts '10: return to main menu'
end

#--------- route_loop ---------------

def route_menu
  route_menu_hint
  loop do
    choice = gets.chomp.to_i
    case choice
    when 1
      new_route_add
    when 2
      next_route_select
    when 3
      prev_route_select
    when 4
      route_station_add
    when 5
      route_station_remove
    when 10
      main_menu_hint
      break
    else
      wrong_hint
      route_menu_hint
    end
  end
end

# =========  programs for route_menu ===============

def route_stations_list_show
  output = 'route stations list => '
  index = 0
  $routes[$routes_index].stations_list.each do |station|
    output += index.to_s + ':' + station.name + ', '
    index += 1
  end
  puts output
end

def routes_list_show
  output = 'routes => '
  index = 0
  $routes.each do |route|
    output += index.to_s + ':' + route.first_last_name + '  '
    index += 1
  end
  puts output
end

def stations_list_show
  output = 'stations => '
  index = 0
  $stations.each do |station|
    output += index.to_s + ':' + station.name + ' '
    index += 1
  end
  puts output
end

def new_route_add
  routes_list_show
  stations_list_show
  puts 'select number of first route station'
  first = gets.chomp.to_i
  puts 'select number of last route station'
  last = gets.chomp.to_i
  $routes << Route.new($stations[first], $stations[last])
  $routes_index = $routes.length - 1
  routes_list_show
  route_menu_hint
end

def next_route_select
  $routes_index += 1
  $routes_index = 0 if $routes_index == $routes.length
  route_menu_hint
end

def prev_route_select
  if $routes_index.zero?
    $routes_index = $routes.length - 1
  else
    $routes_index -= 1
  end
  route_menu_hint
end

def route_station_add
  route_stations_list_show
  stations_list_show
  puts 'select station number for add, please'
  index = gets.chomp.to_i
  $routes[$routes_index].add_station($stations[index])
  route_menu_hint
end

def route_station_remove
  route_stations_list_show
  puts 'select station number for remove, please'
  index = gets.chomp.to_i
  $routes[$routes_index].delete_station(index)
  route_menu_hint
end
