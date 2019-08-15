# frozen_string_literal: true

require_relative 'manufacturer'
# author Brovkin Oleg
# 06.08.2019
# this class have type ('pass', 'cargo')and 'weight'
class Wagon
  include Manufacturer
  attr_reader :type, :busy, :number

  def initialize(type, number)
    @type = type
    validate!
    @busy = 0
    @number = number
  end

  def busy_set(busy)
    @busy = busy if busy <= @number
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  protected

  def validate!
    raise 'Type must be: \'cargo\' or \'pass\'' \
           if type != 'cargo' && type != 'pass'

    true
  end
end



