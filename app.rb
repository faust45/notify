require './config.rb'
require './dir_watcher.rb'

twitter = Twitter::Client.from_config('config.yml')

#status = twitter.status(:post, 'NOT buying overrated iPhone.')

watcher = DirWatcher.new('/home/ftp/ftp_data/raw')
trap("INT") do
  watcher.down
  exit
end

puts 'blin'
gets
