# frozen_string_literal: true

# author Brovkin Oleg
# 07.08.2019

def train_menu_hint
  puts ''
  puts '=== train_Menu_Hint ==='
  trains_list_show
  this_train_wagons_show
  trains_place_show
  puts '1 : new train add'
  puts '2 : next train select '
  puts '3 : prev train select '
  puts '4 : train route select '
  puts '5 : wagon add to current train'
  puts '6 : wagon remove from current train'
  puts '7 : train move to next station'
  puts '8 : train move to prev station'
  puts '10 : return to main menu'
end

#--------- train_loop ---------------

def train_menu
  train_menu_hint
  loop do
    choice = gets.chomp.to_i
    case choice
    when 1
      new_train_add
    when 2
      next_train_select
    when 3
      prev_train_select
    when 4
      train_route_select
    when 5
      train_wagon_add
    when 6
      train_wagon_remove
    when 7
      $trains[$trains_index].next_station_set
      trains_place_show
    when 8
      $trains[$trains_index].prev_station_set
      trains_place_show
    when 10
      main_menu_hint
      break
    else
      wrong_hint
      train_menu_hint
    end
  end
end

# =========  programs for train_menu ===============

# def this_train_number_show
#   puts 'current train number => ' + $trains[$trains_index].number.to_s
# end

def trains_list_show
  output = 'trains => '
  index = 0
  $trains.each do |train|
    output += index.to_s + ':' + train.number.to_s + ', '
    index += 1
  end
  puts output
end

def train_stations_list_show
  # output = 'train stations list => '
  # index = 0
  # $trains[$trains_index].stations_list.each do |station|
  #   output += index.to_s + ':' + station.name + ', '
  #   index += 1
  # end
  # puts output
end

def this_train_wagons_show
  puts 'train number ' + $trains[$trains_index].number.to_s + \
       ' have ' + $trains[$trains_index].wagons.to_s + ' wagons'
end

def trains_place_show
  puts 'train now places at \'' \
  + $trains[$trains_index].current_station_name + '\' station'
end

def this_train_place_show
  name = $trains[$trains_index].current_station_name
  train_number = $trains[$trains_index].number.to_s
  puts "train = #{train_number} now place on \"#{name}\" station"
end

def new_train_add
  trains_list_show
  puts 'tape train number, please'
  number = gets.chomp.to_i
  puts 'tape train type \'pass\' or \'cargo\' ?'
  type = gets.chomp.to_s
  $trains << PassengerTrain.new(number) if type == 'pass'
  $trains << CargoTrain.new(number) if type == 'cargo'
  train_menu_hint
end

def next_train_select
  $trains_index += 1
  $trains_index = 0 if $trains_index == $trains.length
  train_menu_hint
end

def prev_train_select
  if $trains_index.zero?
    $trains_index = $trains.length - 1
  else
    $trains_index -= 1
  end
  train_menu_hint
end

def train_route_select
  routes_list_show
  puts 'select number of route, please'
  $routes_index = gets.chomp.to_i
  $trains[$trains_index].route_set($routes[$routes_index])
  train_menu_hint
end

def train_wagon_add
  puts 'select type of wagon \cargo\' or \'pass\' '
  if gets.chomp == 'pass'
    $trains[$trains_index].wagon_add(Wagon.new('pass'))
  else
    $trains[$trains_index].wagon_add(Wagon.new('cargo'))
  end
  train_menu_hint
end

def train_wagon_remove
  $trains[$trains_index].wagon_remove.to_s
  train_menu_hint
end
