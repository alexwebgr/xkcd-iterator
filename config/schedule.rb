# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
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

# Learn more: http://github.com/javan/whenever
# dont run whenever --update-crontab because it will create new entries for each release

set :environment, 'production'

every :day, at: '7am' do
  runner 'Subscription.send_comic'
end

every :sunday, at: '1pm' do
   runner 'Comic.update_tree'
end

