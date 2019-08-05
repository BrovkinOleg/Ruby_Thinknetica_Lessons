# frozen_string_literal: true

# author Brovkin Oleg
# 04.08.2019
require_relative 'route_class.rb'
require_relative 'train_class.rb'
# class Station must get trains by one, returns list of trains,
# can return list of trains by type of train (cargo, passenger),
# can clear train one by one
class Station
  attr_accessor :name, :location
  attr_reader :train_list

  def initialize(name, location)
    @name = name.to_s.capitalize
    @location = location.to_s
    @train_list = []
  end

  def add_train(name)
    @train_list << name
  end

  def remove_train(train_name)
    @train_list.delete_if { |name| train_name.to_s.upcase == name }
  end
end

