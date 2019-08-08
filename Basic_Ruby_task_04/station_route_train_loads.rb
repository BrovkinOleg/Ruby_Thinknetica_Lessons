# frozen_string_literal: true

# author Brovkin Oleg
# 07.08.2019
# require_relative 'main'

$stations << moscow = Station.new('Moscow', 0)
$stations << murmansk = Station.new('Murmansk', 600)
$stations << brest = Station.new('Brest', 120)
$stations << tula = Station.new('Tula', 100)
$stations << orel = Station.new('Orel', 200)
$stations << novgorod = Station.new('Novgorod', 300)
$stations << pskov = Station.new('Pskov', 150)
$stations << minsk = Station.new('Minsk', 150)
$stations << mogilev = Station.new('Mogilev', 150)
$stations << kiev = Station.new('Kiev', 150)

$routes << north = Route.new(moscow, murmansk)
north.add_station(tula)
north.add_station(orel)
north.add_station(novgorod)

$routes << west = Route.new(tula, brest)
west.add_station(pskov)
west.add_station(minsk)
west.add_station(mogilev)
west.add_station(kiev)

$routes << south = Route.new(orel, pskov)
south.add_station(tula)
south.add_station(minsk)
south.add_station(orel)
south.add_station(kiev)

$routes << east = Route.new(kiev, minsk)
east.add_station(novgorod)
east.add_station(minsk)
east.add_station(brest)
east.add_station(kiev)

def random_name
  ('0'..'9').to_a.shuffle[0..2].join.capitalize
end
(0..3).each do |i|
  $trains << PassengerTrain.new(random_name)
  $trains[i].route_set($routes[i])
end
(0..3).each do |i|
  $trains << CargoTrain.new(random_name)
  $trains[i + 4].route_set($routes[i])
end
$trains.each { |train| train.place_station = 0 }

