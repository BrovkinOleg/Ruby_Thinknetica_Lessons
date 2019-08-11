# frozen_string_literal: true

require_relative 'manufacturer'
# author Brovkin Oleg
# 06.08.2019
# this class have type ('pass', 'cargo')and 'weight'
class Wagon
  include Manufacturer
  attr_reader :type

  def initialize
    @type = type
  end
end



