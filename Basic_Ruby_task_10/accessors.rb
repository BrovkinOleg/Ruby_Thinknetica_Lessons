# frozen_string_literal: true

# author Brovkin Oleg
# 17.08.2019
module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      name_history = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}_history") do \
        instance_variable_get(name_history)
      end
      memory = []
      define_method("#{name}=".to_sym) do |value|
        memory << instance_variable_get(var_name)
        memory.compact!
        instance_variable_set(name_history, memory)
        instance_variable_set(var_name, value)
      end
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise 'class name mismatch !!!' unless name.is_a? class_name

      instance_variable_set(var_name, value)
    end
  end
end

# ====================  check  =========================
# class Foo
#   extend Accessors
#
#   attr_accessor_with_history :a, :b, :c, :d
# end
# a = Foo.new
# a.strong_attr_accessor(train, pass)
# a.a = 5; a.a = 6; a.a = 7; a.a = 8
# puts a.instance_eval('@a_history')
# puts a.a_history

# a.b = 123; a.b = 456; a.b = 789; a.b=000
# # puts a.instance_eval('@b_history')
# puts a.b_history
