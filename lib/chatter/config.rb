module Chatter
  class Config
  end

  class Default < Config
    def self.greeting
      'Hello' #Hi there! What is your name?'
    end

    def self.bot; Chatter::Bots::Clever.new end
  end
end


