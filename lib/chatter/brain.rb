module Chatter
  module Brain
    protected
    def on(context)
      @context = context
      self
    end

    def say(message)
      remember(message, @context)
      self
    end

    def remember(message, context="")
      add(message.chomp, context)
      dump_memory # for now update memory every time, just in case user quits with ^C
      self
    end

    def respond_to(msg)
      msg.chomp!
      options = store.has_key?(msg) ? memories_for(msg) : stock_phrases
      @response = options.sample
      self 
    end

    def memories_for(msg)
      store[msg]
    end

    private
    def store
      @store ||=  {}
    end

    def add(msg, context)
      store[context] ||= []
      store[context] << msg
    end

    def stock_phrases
      [ "Hi!", "What is your name?", "How are you?", "How's life?" ] + 
	store.values.inject(&:+)
    end

    def clear_memory
      @store = {}
    end

    def load_memory(from="brain.dat")
      if File.exists?(from)
	File.open(from) do |f| 
	  @store = Marshal.load(f)
	end
      end
    end

    def dump_memory(to="brain.dat")
      File.open(to, 'w') { |f| Marshal.dump(@store, f) }
    end
  end
end
