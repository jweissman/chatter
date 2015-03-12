module Chatter
  class Bot
    include Logging

    def initialize
      @greeting = Default.greeting
      @response = nil
      @active   = true
    end
  
    def converse!
      greet
      converse while is_active?
      self
    end

    def converse
      read
      parse @message
      info "got:  #@message"
      write @response
      info "sent: #@response"
      self
    end

    def set_message(message)
      @message = message
      self
    end

    def use_harness(harness)
      @harness = harness
      self
    end

    def greet
      write @greeting
      self
    end

    def deactivate
      @active = false
      self
    end

    protected
    def parse(input)
      deactivate if input =~ /bye/
      self
    end

    def write(msg)
      @harness.write(msg)
    end

    def read
      @harness.read
    end

    private
    def is_active?
      @active
    end
  end
end
