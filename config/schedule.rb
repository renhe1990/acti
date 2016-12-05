# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
 job_type :runner,  "cd :path && bin/rails runner -e :environment ':task' :output"
 set :output, "~/rails_app/shared/log/cron_log.log"
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
  #command "curl https://acti.amway.com.cn"
  runner "KeepDbConnect.connectdb"
end

# Learn more: http://github.com/javan/whenever
