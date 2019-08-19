# frozen_string_literal: true

# author Brovkin Oleg
# 04.08.2019
# require_relative 'valid'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'
# class Station must get trains by one, returns list of trains,
# can return list of trains by type of train (cargo, passenger),
# can clear train one by one
class Station
  include InstanceCounter
  # include Valid
  extend Accessors
  include Validation

  NAME = /^[A-Z][a-z]{2,14}$/.freeze

  validate :name, :presence
  validate :name, :format, NAME
  validate :location, :type, 'Integer'

  attr_accessor :name, :location
  attr_reader :trains_list
  @@stations_all = []

  def self.all
    @@stations_all
  end

  def initialize(name, location)
    @name = name
    @location = location
    validate!
    @trains_list = []
    @@stations_all << self
    register_instance
  end

  def each_train
    @trains_list.each do |train|
      yield(train) if @trains_list.length.nonzero?
    end
  end

  def trains?
    @trains_list.length.nonzero?
  end

  def add_train(train)
    @trains_list << train
  end

  def remove_train(train)
    @trains_list.each_with_index do |value, i|
      @trains_list.delete_at(i) if train == value
    end
    @trains_list.compact
  end

  def trains_type_list(type)
    trains_type = []
    @trains_list.each do |train|
      trains_type << train if train.type == type
    end
    trains_type
  end

  # protected

  # def validate!
  #   raise 'Name must be like: \'Moscow\'' if name !~ NAME
  #   raise 'Location must be: from 0 to 1000' if location > 1000
  # end
end
