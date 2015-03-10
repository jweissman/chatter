require 'logger'

module Chatter
  class Bot
    def initialize
      @name     = self.class.name.split('::').last
      @greeting = Default.greeting
      @response = nil
      @active   = true
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
      if input =~ /hi/
        @response = 'Hi'
      elsif input =~ /movies/
        @response = 'Movies are cool'
      elsif input =~ /bye/
        @response = 'Bye'
        @active = false
      else 
        @response = 'what? :('
      end
      self
    end

    def write(msg, pipe_out=STDOUT)
      @log.info "#{@name.upcase}: #{msg}"
      pipe_out.puts(msg)
      self
    end

    def read(pipe_in=STDIN)
      @message = pipe_in.gets
      @log.info "HUMAN: #@message"
      self
    end

    private

    def active?
      @active
    end
  end
end
