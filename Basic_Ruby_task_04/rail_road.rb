# frozen_string_literal: true

# author Brovkin Oleg
# 08.08.2019

# global arrays for stations, trains, routers
class RailRoad

  attr_accessor :stations, :trains, :routes, :wagons

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
    @stations_index = 0
    @routes_index = 0
    @trains_index = 0
  end

  def main_menu
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

  def route_menu_hint
    puts ''
    puts '=== route_Menu_Hint ==='
    routes_list_show
    name = @routes[@routes_index]&.first_last_name
    puts "current route => #{name}"
    route_stations_list_show
    puts '1 : add new route'
    puts '2 : select next route in list'
    puts '3 : select prev route in list'
    puts '4 : add station to route'
    puts '5 : remove station from route'
    puts '10: return to main menu'
  end

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

  def stations_list_show
    output = 'stations => '
    index = 0
    @stations.each do |station|
      output += index.to_s + ':' + station.name + ' '
      index += 1
    end
    puts output
  end

  def routes_list_show
    output = 'routes => '
    index = 0
    @routes&.each do |route|
      output += index.to_s + ':' + route.first_last_name + '  '
      index += 1
    end
    puts output
  end

  def route_stations_list_show
    output = 'route stations list => '
    index = 0
    @routes[@routes_index]&.stations_list&.each do |station|
      output += index.to_s + ':' + station.name + ', '
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
    @routes << Route.new(@stations[first], @stations[last])
    @routes_index = @routes.length - 1
    routes_list_show
    route_menu_hint
  end

  def next_route_select
    @routes_index += 1
    @routes_index = 0 if @routes_index == @routes.length
    route_menu_hint
  end

  def prev_route_select
    if @routes_index.zero?
      @routes_index = @routes.length - 1
    else
      @routes_index -= 1
    end
    route_menu_hint
  end

  def route_station_add
    route_stations_list_show
    stations_list_show
    puts 'select station number for add, please'
    index = gets.chomp.to_i
    @routes[@routes_index]&.add_station(@stations[index])
    route_menu_hint
  end

  def route_station_remove
    route_stations_list_show
    puts 'select station number for remove, please'
    index = gets.chomp.to_i
    @routes[@routes_index]&.delete_station(index)
    route_menu_hint
  end

  def station_instance_add
    stations_list_show
    puts 'tape name of station, please'
    name = gets.chomp
    puts 'tape location \'200\', please'
    location = gets.chomp.to_i
    @stations << Station.new(name, location)
    stations_list_show
    main_menu_hint
  end

  def station_trains_placed
    trains_list_show
    stations_list_show
    puts 'select station index, please'
    index = gets.chomp.to_i
    output = "trains placed on #{@stations[index]&.name} => "
    @trains.each do |train|
      find_name = train.route.stations_list[train.place_station].name
      output += train.number + ', ' if @stations[index].name == find_name
    end
    puts output
  end

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
        @trains[@trains_index]&.next_station_set
        trains_place_show
      when 8
        @trains[@trains_index]&.prev_station_set
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

  def trains_list_show
    output = 'trains => '
    index = 0
    @trains.each do |train|
      output += index.to_s + ':' + train.number.to_s + ', '
      index += 1
    end
    puts output
  end

  def this_train_wagons_show
    train = @trains[@trains_index]&.number.to_s
    number = @trains[@trains_index]&.wagons.to_s
    puts "train number \"#{train}\" have #{number} wagons"
  end

  def trains_place_show
    check = @trains[@trains_index]&.route.nil?
    name = @trains[@trains_index]&.current_station_name unless check
    puts "train now places at \"#{name}\" station"
  end

  def this_train_place_show
    name = @trains[@trains_index]&.current_station_name
    train_number = @trains[@trains_index]&.number.to_s
    puts "train = #{train_number} now place on \"#{name}\" station"
  end

  def new_train_add
    trains_list_show
    puts 'tape train number, please'
    number = gets.chomp.to_i
    puts 'tape train type \'pass\' or \'cargo\' ?'
    type = gets.chomp.to_s
    @trains << PassengerTrain.new(number) if type == 'pass'
    @trains << CargoTrain.new(number) if type == 'cargo'
    train_menu_hint
  end

  def next_train_select
    @trains_index += 1
    @trains_index = 0 if @trains_index == @trains.length
    train_menu_hint
  end

  def prev_train_select
    if @trains_index.zero?
      @trains_index = @trains.length - 1
    else
      @trains_index -= 1
    end
    train_menu_hint
  end

  def train_route_select
    routes_list_show
    puts 'select number of route, please'
    @routes_index = gets.chomp.to_i
    @trains[@trains_index]&.route_set(@routes[@routes_index]) unless rt_nil?
    train_menu_hint
  end

  def train_wagon_add
    puts 'select type of wagon \'cargo\' or \'pass\' '
    if gets.chomp == 'pass'
      @trains[@trains_index]&.wagon_add(Wagon.new('pass'))
    else
      @trains[@trains_index]&.wagon_add(Wagon.new('cargo'))
    end
    train_menu_hint
  end

  def train_wagon_remove
    @trains[@trains_index]&.wagon_remove.to_s
    train_menu_hint
  end

  def wrong_hint
    puts 'wrong number, try again'
  end

  def st_nil?
    @stations[0].nil?
  end

  def rt_nil?
    @routes[0].nil?
  end

  def tr_nil?
    @trains[0].nil?
  end
end


