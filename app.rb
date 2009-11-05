require './logger.rb'
require './config.rb'
require './dir_watcher.rb'

twitter = Twitter::Client.from_config('config.yml')

#status = twitter.status(:post, 'NOT buying overrated iPhone.')

trap("INT") do
  watcher.down
  exit
end
watcher = DirWatcher.new('/home/ftp/ftp_data/raw')

log 'main thread continue'
gets
