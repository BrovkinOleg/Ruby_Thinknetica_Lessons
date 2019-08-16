# frozen_string_literal: true

# author Brovkin Oleg
# 10.08.2019
# include module
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  # class
  module ClassMethods
    attr_accessor :instances
  end
  # instance
  module InstanceMethods
    # protected
    private
    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end
end
