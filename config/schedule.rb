# Use this file to easily define all of your cron jobs.
#

set :output, "/home/feenix/gateway/shared/log/whenever.log"

every :hour do
   rake "dns:update"
end

# Learn more: http://github.com/javan/whenever
