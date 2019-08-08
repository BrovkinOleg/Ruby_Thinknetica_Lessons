# frozen_string_literal: true

# author Brovkin Oleg
# 06.08.2019
# this class have type ('pass', 'cargo')and 'weight'
class Wagon
  attr_reader :type

  def initialize(type)
    @type = type
  end
end
