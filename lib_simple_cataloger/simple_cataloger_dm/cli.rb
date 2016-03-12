# -*- coding: utf-8 -*-

#
# rubygems
#
#require 'rubygems'
#begin
#  require "bundler/setup"
#rescue LoadError
#end

require 'sinatra/base'

gem 'sinatra-group-items', "0.0.1"
require 'sinatra/group_items'

require 'haml'
require 'sass'
require 'json'

#
# server
#
require 'simple_cataloger_server/helpers'
require 'simple_cataloger_server/my_static'
require 'simple_cataloger_server/web_server'

#
# cli
#
require 'simple_cataloger_cli/cli_cat'
Dir[ File.join(File.dirname(__FILE__), "simple_cataloger_cli", "cmd*.rb") ].each { |f|require f }
