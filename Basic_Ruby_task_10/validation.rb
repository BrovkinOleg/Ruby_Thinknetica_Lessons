# frozen_string_literal: true

# author Brovkin Oleg
# 17.08.2019
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(var, validation, option = nil)
      @array_validate ||= []
      @array_validate << { type: validation, var: var, option: option }
    end

    def array_validate
      @array_validate
    end
  end

  module InstanceMethods
    def validate!
      self.class.array_validate.each do |validation|
        val = instance_variable_get("@#{validation[:var]}")
        program_name = "validate_#{validation[:type]}"
        send(program_name, val, *validation[:option])
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

  def validate_presence(var)
    raise 'name string is empty or nil' \
      if (var.is_a?(String) && var.empty?) || var.nil?
  end

  def validate_format(var, format)
    raise 'wrong name format' if var.to_s !~ format
  end

  def validate_type(var, type)
    var_class = var.class.to_s
    raise "class type error \"#{var_class}\"" if var_class != type
  end
end

# ================ check =====================
