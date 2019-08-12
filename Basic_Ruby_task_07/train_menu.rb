# frozen_string_literal: true

# author Brovkin Oleg
# 07.08.2019

def train_menu_hint
  puts ''
  puts '    Train_Menu_Hint'
  puts '1 : train number set \'024\' '
  puts '2 : train wagon add'
  puts '3 : train wagon remove'
  puts '100 : return to main menu'
end

#--------- train_loop ---------------

def train_menu
  train_menu_hint
  loop do
    choice = gets.chomp.to_i
    case choice
    when 1
      # train_index_set
    when 2
      # train_route_set
    when 3
      # train_wagon_add
    when 4
      # train_wagon_remove
    when 100
      main_menu_hint
      break
    else
      wrong_hint
      route_menu_hint
    end
  end
end

# =========  programs for train_menu ===============

def trains_route_set
  puts 'tape number of train, please \'123\' '
  number = gets.chomp
  puts "tape index of route 0,.. #{@routes.length}"
  index = gets.chomp
  @train_index = index
  @trains.each do |train|
    train.route_set(@routes[index]) if train.number == number
  end
end

def train_wagon_add
  puts 'tape number of train, please \'123\' '
  number = gets.chomp

end