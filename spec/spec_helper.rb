gem 'rspec', '~> 2.4'
require 'rspec'
require 'chatter'

include Chatter

Dir.glob(::File.expand_path('../support/*.rb', __FILE__)).each { |f| require_relative f }
