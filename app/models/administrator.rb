class Administrator < ApplicationRecord
  include PasswordHolder

  def active?
    !suspended?
  end
end
