require './logger.rb'
require './config.rb'
require './dir_watcher.rb'

#twitter = Twitter::Client.from_config('config.yml')
#status = twitter.status(:post, 'NOT buying overrated iPhone.')

log 'start'
watcher = DirWatcher.new('/home/ftp/ftp_data/raw')

trap("INT") do
  watcher.down
  exit
end

watcher.up
log 'main thread continue'

gets
