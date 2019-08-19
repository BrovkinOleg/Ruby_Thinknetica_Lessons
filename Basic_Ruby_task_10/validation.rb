# frozen_string_literal: true

# author Brovkin Oleg
# 17.08.2019
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :array_validate
    def validate(var, validation, condition = nil)
      @@array_validate ||= []
      @@array_validate << { validation => { var: var, condition: condition } }
    end

    def array_get
      @@array_validate
    end
  end
  module InstanceMethods
    def validate!
      self.class.array_get.each do |validation|
        validation.each do |check, args|
          send(check, @number) if check.to_s == 'presence'
          send(check, @number, args[:condition]) if check.to_s == 'format'
          send(check, @number, args[:condition]) if check.to_s == 'type'
        end
      end
    end

    def valid?
      validate!
      true
    rescue RuntimeError => e
      puts e.inspect
      false
    end
  end

  def presence(var)
    raise 'name string is empty or nil' \
      if (var.is_a?(String) && var.empty?) || var.nil?
  rescue RuntimeError => e
    puts e.inspect
  end

  def format(var, format)
    raise 'wrong name format' if var.to_s !~ format
  rescue RuntimeError => e
    puts e.inspect
  end

  def type(var, _type)
    self_class = self.class
    raise "class type error \"#{var}\"" unless \
      self_class != PassengerTrain || CargoTrain || Station || Wagon
  rescue RuntimeError => e
    puts e.inspect
  end
end

# ================ check =====================
# class Fool
#   include Validation
# end
#
# Fool.validate 'Fool', 'presence'
# Fool.validate 'Fool', 'format', /^[A-Z][a-z]{3}/
# Fool.validate 'Fool', 'type', String

# Fool.validate 'train', 'presence'
# Fool.validate 'cat', 'presence'

# cat = Fool.new
# puts cat.valid?
