class Province < DatabaseConnection
  has_many :users

  has_many :cities
end
