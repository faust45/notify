require 'rinotify'
require 'find'

class DirWatcher

  def initialize(dir_path, &block)
    @dir_path = dir_path
    @block = block

    @notify = RInotify.new
    @notify.add_watch(@dir_path, RInotify::CREATE | RInotify::DELETE | RInotify::MOVE)

    @thread = Thread.new { start_watch }
    @thread.join
  end

  def start_watch
    while true do
      has_events = rinotify.wait_for_events(2)
      if has_events
        @notify.each_event do |event|
          case true
            when event.check_mask(RInotify::CREATE)
              log("file was created #{event.name}")
            when event.check_mask(RInotify::DELETE)
              log("file was deleted #{event.name}")
          end
        end 
      else
        log("Timed out\n")
      end
    end
  end

  def down
    log("watcher down")
    @thread.kill
    @notify.close
  end

end
