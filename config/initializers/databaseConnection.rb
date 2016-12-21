class DatabaseConnection < ActiveRecord::Base
  self.abstract_class = true
  #establish_connection DatabaseCnf[:production]
  establish_connection :development
end
