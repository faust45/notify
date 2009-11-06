require 'rinotify'
require 'find'

class DirWatcher

  def initialize(dir_path, &block)
    @dir_path = dir_path
    @handlers = {}
    block.bind(self).call

    @notify = RInotify.new
    @notify.add_watch(@dir_path, RInotify::CREATE | RInotify::DELETE | RInotify::MOVE)
  end

  def up
    @thread = Thread.new { start_watch }
    @thread.join
  end

  def down
    log("watcher down")
    @thread.kill
    @notify.close
  end

  def start_watch
    while true do
      has_events = @notify.wait_for_events(2)

      if has_events
        @notify.each_event do |event|
          case true
            when event.check_mask(RInotify::CREATE)
              @handlers[:on_create].map{|block| block.call(event) }
            when event.check_mask(RInotify::DELETE)
              @handlers[:on_delete].map{|block| block.call(event) }
          end
        end 
      else
        log("Timed out\n")
      end

      sleep(5)
    end
  end

  def on_create(&block)
    @handlers[:on_create] ||= []
    @handlers[:on_create] << block
  end

  def on_delete(&block)
    @handlers[:on_delete] ||= []
    @handlers[:on_delete] << block
  end

end
