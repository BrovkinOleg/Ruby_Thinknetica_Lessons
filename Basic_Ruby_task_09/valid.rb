# frozen_string_literal: true

# author Brovkin Oleg
# 12.08.2019
module Valid
  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end
end
