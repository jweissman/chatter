module Chatter
  class Config
  end

  class Default < Config
    def self.greeting
      'Hello!'
    end

    def self.bot
      Chatter::Bots::Clever.new 
    end
  end
end


