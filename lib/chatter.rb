require 'chatter/version'
require 'chatter/config'
require 'chatter/brain'
require 'chatter/bot'

require 'chatter/bots/eliza'
require 'chatter/bots/clever'

module Chatter
  class Harness
    def initialize(argv, stdin=STDIN, stdout=STDOUT, stderr=STDERR, kernel=Kernel)
      @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
    end

    def execute!
      @bot = Default.bot
      @bot.converse!(@stdin,@stdout,@stderr)

      # your code here, assign a value to exitstatus
      @kernel.exit(0) #exitstatus)
    end
  end
end


Chatter::Bot.new.converse! if __FILE__ == $0
