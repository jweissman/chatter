module Chatter
  class Bot
    def initialize
      @name     = self.class.name.split('::').last
      @greeting = Default.greeting
      @response = nil
      @active   = true

      Dir.mkdir('logs') unless Dir.exists?('logs')
      @log      = Logger.new("logs/#@name.log")
    end
  
    def converse!(sin=STDIN,sout=STDOUT,serr=STDERR)
      @log.info "---> converse!"
      greet(sout)
      converse(sin,sout,serr) while active?
    end

    def converse(pipe_in=STDIN,pipe_out=STDOUT,pipe_err=STDERR)
      read(pipe_in)
      parse(@message)
      write(@response, pipe_out)
      self
    end

    protected

    def greet(pipe_out=STDOUT)
      write(@greeting, pipe_out)
    end

    def parse(input)
      raise 'implement in subclass'
      self
    end

    def write(msg, pipe_out=STDOUT)
      @log.info "#{@name.upcase}: #{msg}"
      pipe_out.puts(msg)
      self
    end

    def read(pipe_in=STDIN)
      @message = pipe_in.gets.chomp
      @log.info "HUMAN: #@message"
      self
    end

    private

    def active?
      @active
    end
  end
end
