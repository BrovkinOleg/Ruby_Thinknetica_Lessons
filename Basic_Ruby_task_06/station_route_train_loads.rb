# frozen_string_literal: true

# author Brovkin Oleg
# 07.08.2019
require_relative 'main'

moscow = Station.new('Moscow', 0)
murmansk = Station.new('Murmansk', 600)
brest = Station.new('Brest', 800)

na = Station.new('north_a', 100)
nb = Station.new('north_b', 200)
nc = Station.new('north_c', 300)
nd = Station.new('north_d', 400)
ne = Station.new('north_e', 500)
north = Route.new(moscow, murmansk)
north.add_station(na)
north.add_station(nb)
north.add_station(nc)
north.add_station(nd)
north.add_station(ne)
@routes << north

wa = Station.new('west_a', 150)
wb = Station.new('west_a', 150)
wc = Station.new('west_a', 150)
wd = Station.new('west_a', 150)
west = Route.new(moscow, brest)
west.add_station(wa)
west.add_station(wb)
west.add_station(wc)
west.add_station(wd)
@routes << west

#
# my_train = Train.new(123, 'cargo', 30)
# my_train.route_set(route_001)
# 3.times { my_train.next_station_set }
# puts my_train.name_station_get('prev')
# puts my_train.name_station_get
# puts my_train.name_station_get('next')
# 6.times { puts my_train.prev_station_set }
# puts my_train.next_station
# my_train.next_station
# my_train.next_station
# my_train.next_station

# my_train.decrement_wagons
# puts my_train.wagons_count
# my_train.speed_set(45)
# puts my_train.train_speed
# puts my_train.train_type
