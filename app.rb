require './config.rb'
require './dir_watcher.rb'

twitter = Twitter::Client.from_config('config.yml')

#status = twitter.status(:post, 'NOT buying overrated iPhone.')

watcher = DirWatcher.new('/home/ftp/ftp_data/raw')
puts 'blin'
gets
watcher.down 
