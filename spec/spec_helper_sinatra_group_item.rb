$:.unshift(File.dirname(__FILE__))
$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'date'

require 'rubygems'
require 'haml'
require 'rspec'
require 'rspec/collection_matchers'
require 'rack/test'
require 'sinatra/base'



RSpec.configure do |config|
end

#set :environment, :test
#set :run, false
#set :raise_errors, true
#set :logging, false
