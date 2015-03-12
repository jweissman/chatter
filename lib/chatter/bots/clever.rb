module Chatter
  module Bots
    class Clever < Bot
      include Brain

      def parse(message)
	message.chomp!
	on(conversation.last).say(message)

	conversation << message

	if message =~ /bye/
	  @response = 'later!'
	  deactivate
	else
	  respond_to(message)
	end

	conversation << @response
	self
      end

      def greet
	load_memory
	conversation << @greeting
	super
      end

      protected
      def conversation
	@conversation ||= []
      end
    end
  end
end
