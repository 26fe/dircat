# require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


require (File.join(File.dirname(__FILE__), %w{ .. examples_sinatra_group_items classic_style classic_app}))
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
