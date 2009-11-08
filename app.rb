#!/usr/local/bin/ruby

NOTIFY_DIR = File.dirname(__FILE__) 
require NOTIFY_DIR + '/logger.rb'
require NOTIFY_DIR + '/config.rb'
require NOTIFY_DIR + '/dir_watcher.rb'

twitter = Twitter::Client.from_config('config.yml')

watcher = DirWatcher.new('/home/ftp/ftp_data/raw') do
  on_create do |event|
    #twitter.status(:post, "New file #{file_name}.")
    log("file was created #{event.name}")
  end

  on_delete do |event|
    #twitter.status(:post, "File #{file_name} was deleted.")
    log("file was deleted #{event.name}")
  end
end

trap("INT") do
  watcher.down
  exit
end

watcher.up
log 'main thread continue'
