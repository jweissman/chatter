module Chatter
  module Bots
    class Clever < Bot
      include Brain

      def conversation
	@conversation ||= []
      end

      def parse(message)
	message.chomp!
	remember(message, conversation.last)
	conversation << message

	if message =~ /bye/
	  @active = false 
	  @response = 'later!'
	else
	  @response = response_to(message)
	end

	conversation << @response
	self
      end

      def greet(pipe_out=STDOUT)
	load_memory
	conversation << @greeting
	super(pipe_out)
      end
    end
  end
end
