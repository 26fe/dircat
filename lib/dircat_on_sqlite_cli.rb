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

require 'dircat_on_sqlite'

#
# server
#
require 'dircat/server/helpers'
require 'dircat/server/my_static'
require 'dircat/server/web_server'

#
# cli
#
require 'optparse-command'

command_dir = File.join(File.dirname(__FILE__), 'dircat', 'cat_on_sqlite_cli')
require File.join(command_dir, 'cli_cat')
unless Dir.exist? command_dir
  raise "cannot found directory '#{command_dir}'"
end
Dir[ File.join(command_dir, "cmd*.rb") ].each { |f|require f }
