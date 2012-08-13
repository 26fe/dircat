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
require 'sinatra/group_items'

require 'haml'
require 'sass'
require 'json'

#
# server
#
require 'simple_cataloger/server/helpers'
require 'simple_cataloger/server/my_static'
require 'simple_cataloger/server/web_server'

#
# cli
#
require 'optparse-command'

require 'simple_cataloger/cli/cli_cat'
Dir[ File.join(File.dirname(__FILE__), "cli", "cmd*.rb") ].each { |f|require f }
