# f_spec_helper = File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
# require f_spec_helper

$:.unshift(File.join(File.dirname(__FILE__), '..'))
$:.unshift(File.join(File.dirname(__FILE__), '..', '..', 'lib'))


# test
#require 'sinatra-group-items/item'
#require 'sinatra/group_items'
#include Sinatra::GroupItems
#require 'sinatra-group-items/test_app'
# set :environment, :test

ex_path = File.join(File.dirname(__FILE__), %w{ .. .. examples sinatra-group-items classic_style})
ex_path = File.realpath(ex_path)
require File.join(ex_path, 'classic_app')
require 'rspec'
require 'rack/test'

set :environment, :test

describe Sinatra::GroupItems do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'get /' do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to match(/Words/)
  end

end
