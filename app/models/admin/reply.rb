class Admin::Reply < ActiveRecord::Base
	=begin
    def reconnectDatabase
	    logger.warn "@@@@@@@@@@@@reconnectDatabase run" << Time.new.strftime("%Y-%m-%d %H:%M:%S")
	    establish_connection :production
	end
	=end
end
