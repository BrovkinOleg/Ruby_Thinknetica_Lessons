# frozen_string_literal: true

# author Brovkin Oleg
# 08.08.2019

require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'wagon'
require_relative 'pass_wagon'
require_relative 'cargo_wagon'
require_relative 'rail_road'

hub = RailRoad.new

# hub.trains_placed_on_the_station
# fill data to stations, routes, trains
hub.stations << moscow = Station.new('Moscow', 0)
hub.stations << murmansk = Station.new('Murmansk', 600)
hub.stations << brest = Station.new('Brest', 120)
hub.stations << tula = Station.new('Tula', 100)
hub.stations << orel = Station.new('Orel', 200)
hub.stations << novgorod = Station.new('Novgorod', 300)
hub.stations << pskov = Station.new('Pskov', 150)
hub.stations << minsk = Station.new('Minsk', 250)
hub.stations << mogilev = Station.new('Mogilev', 350)
hub.stations << kiev = Station.new('Kiev', 450)

hub.routes << north = Route.new(moscow, murmansk)
north.add_station(tula)
north.add_station(orel)
north.add_station(novgorod)

hub.routes << west = Route.new(tula, brest)
west.add_station(pskov)
west.add_station(minsk)
west.add_station(mogilev)
west.add_station(brest)

hub.routes << south = Route.new(orel, pskov)
south.add_station(tula)
south.add_station(minsk)
south.add_station(orel)
south.add_station(kiev)

hub.routes << east = Route.new(kiev, minsk)
east.add_station(novgorod)
east.add_station(minsk)
east.add_station(brest)
east.add_station(kiev)

def random_name
  ('0'..'9').to_a.sample(3).join.capitalize
end
(0..3).each do |i|
  hub.trains << PassengerTrain.new(random_name)
  hub.trains[i].route_set(hub.routes[i])
end
(0..3).each do |i|
  hub.trains << CargoTrain.new(random_name)
  hub.trains[i + 4].route_set(hub.routes[i])
end
hub.trains.each { |train| train.place_station = 0 }

#============= start =======================
# puts Train.instances
# puts Station.instances
# puts CargoTrain.instances
# puts PassengerTrain.instances

hub.main_menu

