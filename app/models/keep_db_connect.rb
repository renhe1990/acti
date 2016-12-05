class KeepDbConnect < ActiveRecord::Base
    def connectdb
	    sql = "SELECT 1 FROM DUAL"
        result = ActiveRecord::Base.connection().execute(sql)
    end
end
