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
  ('A'..'Z').to_a.sample(3).join.upcase + '-' + \
    (0..9).to_a.sample(2).join
end

busy = 0
places = 36
(0..3).each do |i|
  hub.trains << PassengerTrain.new(random_name)
  hub.trains[i].route_set(hub.routes[i])
  1.upto(4) do
    busy += 1
    places -= 1
    pass_wagon = PassWagon.new('pass', places.to_int)
    pass_wagon.busy_set(busy)
    hub.trains[i].wagon_add(pass_wagon)
  end
end

busy = 0
volume = 63
(0..3).each do |i|
  hub.trains << CargoTrain.new(random_name)
  hub.trains[i + 4].route_set(hub.routes[i])
  1.upto(6) do
    busy += 2
    volume -= 2
    cargo_wagon = CargoWagon.new('cargo', volume.to_int)
    cargo_wagon.busy_set(busy)
    hub.trains[i + 4].wagon_add(cargo_wagon)
  end
end

hub.trains.each do |train|
  train.place_station = 0
  landed_station = train.route.stations_list[train.place_station].name
  hub.stations.each do |station|
    station.trains_list << train if station.name == landed_station
  end
end

#============= start =======================
# puts mogilev.valid?
# puts east.valid?
# puts Train.new('ASD-32').valid?
# number = 'ABC-12'
# Train.new(number).valid?
# hub.new_train_add
# hub.train_move_to_next_station

hub.main_menu
