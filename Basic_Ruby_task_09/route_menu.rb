# frozen_string_literal: true

# author Brovkin Oleg
# 16.08.2019

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

def route_menu
  route_menu_hint
  loop do
    choice = gets.chomp.to_i
    case choice
    when 1 then new_route_add
    when 2 then next_route_select
    when 3 then prev_route_select
    when 4 then route_station_add
    when 5 then route_station_remove
    when 0 then main_menu_hint
    else
      wrong_hint
      route_menu_hint
    end
  end
end

def new_route_add
  routes_list_show
  all_stations_list_show
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
  all_stations_list_show
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
