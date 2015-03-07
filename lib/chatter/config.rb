module Chatter
  class Config
  end

  class Default < Config
    def self.name
      'Alice'
    end

    def self.greeting
      'Hello'
    end

    def self.bot; Chatter::Bots::Eliza.new end
  end
end


