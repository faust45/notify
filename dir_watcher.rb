require 'rinotify'
require 'find'

class DirWatcher

  def initialize(dir_path, &block)
    @dir_path = dir_path
    @block = block

    @notify = RInotify.new
    @notify.add_watch(@dir_path, RInotify::CREATE | RInotify::DELETE | RInotify::MOVE)

    Tread.new { start_watch }
  end

  def start_watch
    while true do
      @notify.each_event do |event|
        case true
          when event.check_mask(RInotify::CREATE)
            puts "file was created #{event.name}"
          when event.check_mask(RInotify::DELETE)
            puts "file was deleted #{event.name}"
        end
      end 
    end
  end

  def down
    @notify.close
  end

end
