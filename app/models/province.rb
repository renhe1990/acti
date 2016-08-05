class Province < ActiveRecord::Base
  has_many :users

  has_many :cities
end
