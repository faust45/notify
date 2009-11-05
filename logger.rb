class Logger
  class <<self
    def debug(msg)
      out(msg)
    end

    def out(msg)
      puts msg
    end
  end
end

class Object
  def log(msg)
    Logger.debug(msg)
  end
end
