require 'inotify'
require 'find'

class DirWatcher

  def initialize(dir_path, &block)
    @dir_path = dir_path
    @block = block

    @notify = Inotify.new
    @notify.add_watch(@dir_path, Inotify::CREATE | Inotify::DELETE | Inotify::MOVE)

    @notify.each_event do |event|
      case true
        when event.check_mask(RInotify::CREATE)
          puts "file was created #{event.name}"
        when event.check_mask(RInotify::DELETE)
          puts "file was deleted #{event.name}"
      end
    end 
  end

  def down
    @notify.close
  end

end
