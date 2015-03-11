gem 'rspec', '~> 2.4'
require 'rspec'
require 'chatter'
require 'pathname'

include Chatter

Dir.glob(::File.expand_path('../support/*.rb', __FILE__)).each { |f| require_relative f }

root = Pathname.new(__FILE__).parent.parent

# Allows us to run commands directly, without worrying about the CWD
ENV['PATH'] = "#{root.join('bin').to_s}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
