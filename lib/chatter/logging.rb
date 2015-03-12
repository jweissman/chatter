module Chatter
  module Logging
    def info(msg)
      log.info(msg)
    end

    protected
    def name
      @name ||= self.class.name.split('::').last
    end

    def logging_initialized?
      @logging_initialized ||= false
    end

    def prepare_logger
      Dir.mkdir('logs') unless Dir.exists?('logs')
      Logger.new("logs/#{name}.log")
    end

    private
    def log
      @log ||= prepare_logger
    end
  end
end
