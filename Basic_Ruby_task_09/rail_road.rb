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

  load('train_menu.rb')
  load('route_menu.rb')

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

  def main_menu
    main_menu_hint
    loop do
      choice = gets.chomp.to_i
      case choice
      when 1 then all_stations_list_show
      when 2 then routes_list_show
      when 3 then all_trains_list_show
      when 4 then station_instance_add
      when 5 then route_menu
      when 6 then train_menu
      when 7 then trains_placed_on_the_station
      when 0 then main_menu_hint
      else
        wrong_hint
        main_menu_hint
      end
    end
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

  def station_instance_add
    all_stations_list_show
    puts 'enter name of station, please'
    name = gets.chomp
    puts 'enter location \'200\', please'
    location = gets.chomp.to_i
    begin
      Station.new(name, location)
    rescue RuntimeError
      puts 'Try again, Station name must look like \'Moscow\''
      puts 'location must be from 0 to 1000'
      main_menu_hint
      return
    end
    @stations << Station.new(name, location)
    all_stations_list_show
    main_menu_hint
  end

  def trains_placed_on_the_station
    all_trains_list_show
    all_stations_list_show
    puts 'enter station index, please'
    index = gets.chomp.to_i
    output = "trains placed on \"#{@stations[index]&.name}\" station: "
    if @stations[index].trains?
      @stations[index].each_train { |train| output += train.to_s }
    else
      output = "no trains placed on #{@stations[index]&.name} station"
    end
    puts output
    main_menu_hint
  end

  def wrong_hint
    puts 'wrong number, try again'
  end

  def rt_nil?
    @routes[0].nil?
  end
end
