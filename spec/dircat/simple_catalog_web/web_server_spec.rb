require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module SimpleCataloger
  describe WebServer do

    include Rack::Test::Methods

    def app
      @app ||= WebServer
    end

    it "should respond to /" do
      get '/'
      # pp last_response
      last_response.should be_ok
    end


    #  before(:each) do
    #    @web_server = WebServer.new
    #  end
    #
    #  it "should desc" do
    #    # TODO
    #  end
  end

end
