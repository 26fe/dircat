cwd = File.expand_path(File.join(File.dirname(__FILE__), %w{ .. .. lib}))
$:.unshift(cwd) unless $:.include?(cwd)

require 'sinatra/base'
require 'sinatra/group_items'
require 'haml'

class MyApp < Sinatra::Base   
  helpers Sinatra::GroupItems

  get '/' do
    strings      = %w{
      Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore
      magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
      consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
      Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    }
    @group_items = group_items(strings)
    haml :index
  end
end

MyApp.run!
