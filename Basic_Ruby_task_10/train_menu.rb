# frozen_string_literal: true

# author Brovkin Oleg
# 16.08.2019

def train_menu_hint
  puts ''
  puts '=== train_Menu_Hint ==='
  all_trains_list_show
  this_train_place_show
  train_wagons_info
  puts '1 : new train add'
  puts '2 : next train select '
  puts '3 : prev train select '
  puts '4 : train route select '
  puts '5 : wagon add to current train'
  puts '6 : wagon remove from current train'
  puts '7 : train move to next station'
  puts '8 : train move to prev station'
  puts '9 : seats (or load volume) set'
  puts '0 : return to main menu'
end

def train_menu
  train_menu_hint
  loop do
    choice = gets.chomp.to_i
    case choice
    when 1 then new_train_add
    when 2 then next_train_select
    when 3 then prev_train_select
    when 4 then train_route_select
    when 5 then train_wagon_add
    when 6 then train_wagon_remove
    when 7 then train_move_to_next_station
    when 8 then train_move_to_prev_station
    when 9 then wagon_busy_set
    when 0 then main_menu_hint
    else
      wrong_hint
      train_menu_hint
    end
  end
end

def new_train_add
  all_trains_list_show
  puts 'enter train number like: \'ABC-23\''
  number = gets.chomp
  puts 'enter train type \'pass\' or \'cargo\' ?'
  type = gets.chomp.to_s
  begin
    # Train.new(number).valid?
    @trains << PassengerTrain.new(number) if type == 'pass'
    @trains << CargoTrain.new(number) if type == 'cargo'
  rescue RuntimeError => e
    puts e.inspect
    # wrong_hint
    train_menu_hint
    return
  end
  @trains_ptr = @trains.length - 1
  routes_list_show
  puts 'enter route index for the train'
  index = gets.chomp.to_i
  @trains[@trains_ptr].route_set(@routes[index])
  train_menu_hint
end

def next_train_select
  @trains_ptr += 1
  @trains_ptr = 0 if @trains_ptr == @trains.length
  train_wagons_info
  train_menu_hint
end

def prev_train_select
  if @trains_ptr.zero?
    @trains_ptr = @trains.length - 1
  else
    @trains_ptr -= 1
  end
  train_menu_hint
end

def pass_train?
  @trains[@trains_ptr].instance_of?(PassengerTrain)
end

def train_route_select
  routes_list_show
  puts 'select number of route, please'
  @routes_ptr = gets.chomp.to_i
  @trains[@trains_ptr]&.route_set(@routes[@routes_ptr]) unless rt_nil?
  train_menu_hint
end

def train_wagon_add
  # instance_of? - true only for the class, not for parent class
  wagon = CargoWagon.new('cargo', 64)
  wagon = PassWagon.new('pass', 36) if \
      @trains[@trains_ptr].instance_of?(PassengerTrain)
  @trains[@trains_ptr]&.wagon_add(wagon)
  train_menu_hint
end

def train_wagon_remove
  @trains[@trains_ptr]&.wagon_remove.to_s
  train_menu_hint
end

def train_move_to_next_station
  clear_train_from_all_stations
  @trains[@trains_ptr]&.next_station_set
  push_train_to_station
  this_train_place_show
  train_menu_hint
end

def train_move_to_prev_station
  clear_train_from_all_stations
  @trains[@trains_ptr]&.prev_station_set
  push_train_to_station
  this_train_place_show
  train_menu_hint
end

def wagon_busy_set
  train_wagons_info
  puts 'enter wagon index for change'
  index = gets.chomp.to_i - 1
  if pass_train?
    puts 'enter new busy seats amount'
  else
    puts 'enter new busy volume'
  end
  busy = gets.chomp.to_i
  @trains[@trains_ptr].wagons[index].busy_set(busy)
  train_menu_hint
end

def all_trains_list_show
  output = 'All trains => '
  index = 0
  @trains.each do |train|
    output += index.to_s + ':' + train.number.to_s + ', '
    index += 1
  end
  puts output
end

def train_wagons_info
  train_number = @trains[@trains_ptr].number
  print "Pass_train \"#{train_number}\" (seats/busy)" if pass_train?
  print "Cargo_train \"#{train_number}\" (volume/busy)" unless pass_train?
  ptr = 0
  @trains[@trains_ptr].each_wagon do |wagon|
    ptr += 1
    print " wagon[#{ptr}]=#{wagon.number}/#{wagon.busy}"
  end
  puts ''
end

def this_train_place_show
  name = @trains[@trains_ptr]&.current_station_name
  train_number = @trains[@trains_ptr]&.number.to_s
  puts "current train = #{train_number} now place on \"#{name}\" station"
end

def clear_train_from_all_stations
  leave = @trains[@trains_ptr]
  @stations.each do |station|
    station.each_train do |train|
      station.remove_train(leave) if leave.number == train.number
    end
  end
end

def push_train_to_station
  pointer = @trains[@trains_ptr].place_station
  arrive = @trains[@trains_ptr].route.stations_list[pointer]
  @stations.each do |station|
    station.add_train(@trains[@trains_ptr]) if arrive.name == station.name
  end
end
