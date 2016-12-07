# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
 #set :output, "~/rails_app/shared/log/cron_log.log"
 set :output, "/home/actiadmin/rails_apps/acti/shared/log/cron_log.log"
 #set :output, "/home/amwaysite4/rails_apps/acti/shared/log/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
every 3.minutes do
  #command "curl http://10.32.50.239"
  command "curl https://acti-qa.amway.com.cn"
  #command "curl https://acti.amway.com.cn"
  #rake "acti:keep_db_connect"
end

# Learn more: http://github.com/javan/whenever
