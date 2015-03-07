module Chatter
  class Bot
    # attr_accessor :name, :greeting

    def initialize(name     = Default.name, greeting = Default.greeting)
      @name     = name
      @greeting = greeting
      @response = nil
      @active   = true
    end
  
    def converse!(sin=STDIN,sout=STDOUT,serr=STDERR)
      greet(sout)
      converse(sin,sout,serr) while active?
    end

    def converse(pipe_in=STDIN,pipe_out=STDOUT,pipe_err=STDERR)
      parse(pipe_in.gets)
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
      pipe_out.puts(msg)
      self
    end

    private

    def active?
      @active
    end
  end
end
