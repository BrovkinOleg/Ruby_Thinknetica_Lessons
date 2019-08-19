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
# begin
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
# rescue RuntimeError => e
#   puts e.inspect
# end
# begin
hub.routes << north = Route.new(moscow, murmansk)
hub.routes << west = Route.new(tula, brest)
hub.routes << south = Route.new(orel, pskov)
hub.routes << east = Route.new(kiev, minsk)
# rescue RuntimeError => e
#   puts e.inspect
# end

north.add_station(tula)
north.add_station(orel)
north.add_station(novgorod)

west.add_station(pskov)
west.add_station(minsk)
west.add_station(mogilev)
west.add_station(brest)

south.add_station(tula)
south.add_station(minsk)
south.add_station(orel)
south.add_station(kiev)

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
  begin
    hub.trains << PassengerTrain.new(random_name)
    hub.trains[i].route_set(hub.routes[i])
    1.upto(4) do
      busy += 1
      places -= 1
      pass_wagon = PassWagon.new('pass', places.to_int, busy: busy)
      hub.trains[i].wagon_add(pass_wagon)
    end
  rescue RuntimeError => e
    puts e.inspect
  end
end

busy = 0
volume = 63
(0..3).each do |i|
  begin
    hub.trains << CargoTrain.new(random_name)
    hub.trains[i + 4].route_set(hub.routes[i])
    1.upto(6) do
      busy += 1
      volume -= 1
      cargo_wagon = CargoWagon.new('cargo', volume.to_int, busy: busy)
      hub.trains[i + 4].wagon_add(cargo_wagon)
    end
  rescue RuntimeError => e
    puts e.inspect
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

hub.main_menu
