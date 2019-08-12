# frozen_string_literal: true

# author Brovkin Oleg
# 07.08.2019
# require_relative 'route'
# require_relative 'main'

def route_menu_hint
  puts ''
  puts '    Route_Menu_Hint'
  # puts "current route = #{@routes.length} "
  puts '1 : routes [index] set \'0,..9\' '
  puts '2 : route station add'
  puts '3 : route station remove'
  puts '100 : return to main menu'
end
#--------- route_loop ---------------

def route_menu
  route_menu_hint
  loop do
    choice = gets.chomp.to_i
    case choice
    when 1
      route_index_set
    when 2
      route_station_add
    when 3
      route_station_remove
    when 100
      main_menu_hint
      break
    else
      wrong_hint
      route_menu_hint
    end
  end
end

# =========  programs for route_menu ===============

def route_index_set
  puts "tape index \"0,1..\", routes_number = #{@routes.length}"
  index = gets.chomp
  if index.class == Integer && index <= @routes.length
    @route_index = index
    puts "now route index = #{@route_index} - OK"
  else
    wrong_hint
  end
  route_menu_hint
end

def route_station_add
  puts 'tape station name for add, please'
  name = gets.chomp.capitalize
  @routes[@route_index].add_station(name)
end

def route_station_remove
  puts 'tape station name for remove, please'
  name = gets.chomp.capitalize
  @routes[@route_index].delete_station(name)
end