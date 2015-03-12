require 'logger'

require 'chatter/version'
require 'chatter/config'

require 'chatter/logging'

require 'chatter/bot'

require 'chatter/bots/eliza'

require 'chatter/brain'
require 'chatter/bots/clever'

module Chatter
  class Harness
    def initialize(argv, stdin=STDIN, stdout=STDOUT, stderr=STDERR, kernel=Kernel)
      @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel

      @bot = Default.bot
      @bot.use_harness(self)
    end

    def execute!
      @bot.converse!
      @kernel.exit(0) 
    end

    def read
      @bot.set_message(@stdin.gets)
    end

    def write(msg)
      @stdout.puts(msg)
    end
  end
end


Chatter::Bot.new.converse! if __FILE__ == $0
