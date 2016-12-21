class DBConn::DatabaseConnection < ActiveRecord::Base
<<<<<<< .mine
class DBConn::DatabaseConnection < ActiveRecord::Base
	self.abstract_class = true
	#establish_connection DatabaseCnf[:production]
	establish_connection :production
end


=======
module DBConn
	class DatabaseConnection < ActiveRecord::Base
		self.abstract_class = true
		#establish_connection DatabaseCnf[:production]
		establish_connection :production
	end
end
>>>>>>> .theirs
