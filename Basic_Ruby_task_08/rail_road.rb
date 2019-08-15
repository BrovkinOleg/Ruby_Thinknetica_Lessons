# frozen_string_literal: true

# author Brovkin Oleg
# 08.08.2019

# global arrays for stations, trains, routers
class RailRoad

  attr_accessor :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @stations_ptr = 0
    @routes_ptr = 0
    @trains_ptr = 0
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
        trains_placed_on_the_station
      when 0
        main_menu_hint
      else
        wrong_hint
        main_menu_hint
      end
    end
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
      when 0
        main_menu_hint
        break
      else
        wrong_hint
        route_menu_hint
      end
    end
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
        @trains[@trains_ptr]&.next_station_set
        trains_place_show
        train_menu_hint
      when 8
        @trains[@trains_ptr]&.prev_station_set
        trains_place_show
        train_menu_hint
      when 9
        wagon_busy_set
      when 0
        main_menu_hint
        break
      else
        wrong_hint
        train_menu_hint
      end
    end
  end

  def wagon_busy_set
    puts 'enter wagon index for change'
    index = gets.chomp.to_i - 1
    if pass_train?
      puts 'enter new busy seats number'
    else
      puts 'enter new busy volume'
    end
    busy = gets.chomp.to_i
    @trains[@trains_ptr].wagons[index].busy_set(busy)
    train_menu_hint
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
    puts '0: Main_Menu_Hint'
  end

  def route_menu_hint
    puts ''
    puts '=== route_Menu_Hint ==='
    routes_list_show
    name = @routes[@routes_ptr]&.first_last_name
    puts "current route => #{name}"
    route_stations_list_show
    puts '1 : add new route'
    puts '2 : select next route in list'
    puts '3 : select prev route in list'
    puts '4 : add station to route'
    puts '5 : remove station from route'
    puts '0: return to main menu'
  end

  def train_menu_hint
    puts ''
    puts '=== train_Menu_Hint ==='
    all_trains_list_show
    trains_place_show
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

  def all_stations_list_show
    output = 'All stations => '
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
    @routes[@routes_ptr]&.stations_list&.each do |station|
      output += index.to_s + ':' + station.name + ', '
      index += 1
    end
    puts output
  end

  def new_route_add
    routes_list_show
    stations_list_show
    puts 'select index of first route station'
    first = gets.chomp.to_i
    puts 'select index of last route station'
    last = gets.chomp.to_i
    begin
      Route.new(@stations[first], @stations[last]).valid?
    rescue RuntimeError
      puts 'Stations must be different, try again'
      route_menu_hint
      return
    end
    @routes << Route.new(@stations[first], @stations[last])
    @routes_ptr = @routes.length - 1
    routes_list_show
    route_menu_hint
  end

  def next_route_select
    @routes_ptr += 1
    @routes_ptr = 0 if @routes_ptr == @routes.length
    route_menu_hint
  end

  def prev_route_select
    if @routes_ptr.zero?
      @routes_ptr = @routes.length - 1
    else
      @routes_ptr -= 1
    end
    route_menu_hint
  end

  def route_station_add
    route_stations_list_show
    stations_list_show
    puts 'select station index for add, please'
    index = gets.chomp.to_i
    @routes[@routes_ptr]&.add_station(@stations[index])
    route_menu_hint
  end

  def route_station_remove
    route_stations_list_show
    puts 'select station index for remove, please'
    index = gets.chomp.to_i
    @routes[@routes_ptr]&.delete_station(index)
    route_menu_hint
  end

  def station_instance_add
    stations_list_show
    puts 'enter name of station, please'
    name = gets.chomp
    puts 'enter location \'200\', please'
    location = gets.chomp.to_i
    begin
      Station.new(name, location)
    rescue RuntimeError
      puts 'Try again'
      puts 'Station name must look like \'Moscow\''
      puts 'location must be from 0 to 1000'
      main_menu_hint
      return
    end
    @stations << Station.new(name, location)
    stations_list_show
    main_menu_hint
  end

  def trains_placed_on_the_station
    all_trains_list_show
    all_stations_list_show
    puts 'enter station index, please'
    index = gets.chomp.to_i
    output = "trains placed on \"#{@stations[index]&.name}\" station: "
    if @stations[index].trains?
      @stations[index].train_check do |train|
        output += train.to_s
      end
    else
      output = "no trains placed on #{@stations[index]&.name} station"
    end
    puts output
    main_menu_hint
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

  def this_train_wagons_show
    train = @trains[@trains_ptr]&.number.to_s
    number = @trains[@trains_ptr]&.wagons.length.to_s
    puts "train number \"#{train}\" have #{number} wagons"
  end

  def trains_place_show
    check = @trains[@trains_ptr]&.route.nil?
    name = @trains[@trains_ptr]&.current_station_name unless check
    puts "current train#{@trains[@trains_ptr].to_s}now places at \"#{name}\" station"
  end

  def this_train_place_show
    name = @trains[@trains_ptr]&.current_station_name
    train_number = @trains[@trains_ptr]&.number.to_s
    puts "current train = #{train_number} now place on \"#{name}\" station"
  end

  def new_train_add
    trains_list_show
    puts 'enter train number like: \'ABC-23\''
    number = gets.chomp
    begin
      Train.new(number).valid?
    rescue RuntimeError
      wrong_hint
      train_menu_hint
      return
    end
    puts 'enter train type \'pass\' or \'cargo\' ?'
    type = gets.chomp.to_s
    @trains << PassengerTrain.new(number) if type == 'pass'
    @trains << CargoTrain.new(number) if type == 'cargo'
    @trains_ptr = @trains.length - 1
    train_menu_hint
  end

  def next_train_select
    @trains_ptr += 1
    @trains_ptr = 0 if @trains_ptr == @trains.length
    train_wagons_info
    train_menu_hint
  end

  def pass_train?
    @trains[@trains_ptr].instance_of?(PassengerTrain)
  end

  def train_wagons_info
    train_number = @trains[@trains_ptr].number
    if pass_train?
      message = "Pass_train \"#{train_number}\" (seats/busy)"
      ptr = 1
      @trains[@trains_ptr].wagon_check do |wagon|
        message += " wagon#{ptr}:#{wagon.seats_amount}/#{wagon.busy}"
        ptr += 1
      end
    else
      message = "Cargo_train \"#{train_number}\" (volume/busy)"
      ptr = 1
      @trains[@trains_ptr].wagon_check do |wagon|
        message += " wagon#{ptr}:#{wagon.volume}/#{wagon.busy}"
        ptr += 1
      end
    end
    puts message
  end

  def prev_train_select
    if @trains_ptr.zero?
      @trains_ptr = @trains.length - 1
    else
      @trains_ptr -= 1
    end
    train_menu_hint
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
    wagon = CargoWagon.new(64)
    wagon = PassWagon.new(36) if @trains[@trains_ptr].instance_of?(PassengerTrain)
    @trains[@trains_ptr]&.wagon_add(wagon)
    train_menu_hint
  end

  def train_wagon_remove
    @trains[@trains_ptr]&.wagon_remove.to_s
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


