module Chatter
  module Bots
    class Eliza < Bot
      def parse(message)
        @response = "What do you think about #{message.split(" ").last}?"
	self
      end
    end
  end
end
