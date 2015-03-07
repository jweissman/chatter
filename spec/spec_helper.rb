gem 'rspec', '~> 2.4'
require 'rspec'
require 'chatter/version'
require 'chatter/config'
require 'chatter/bot'
require 'chatter/bots/eliza'

include Chatter

Dir.glob(::File.expand_path('../support/*.rb', __FILE__)).each { |f| require_relative f }
