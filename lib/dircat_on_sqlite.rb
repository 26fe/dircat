# -*- coding: utf-8 -*-
#
# std lib
#
require 'pp'
require 'optparse'
require 'fileutils'
require 'ostruct'

#
# rubygems
#
require 'tree_rb'

require 'active_record'
# gem 'mysql2', "<= 0.3"
# require 'mysql2'

#
# simple catalog
#
require 'dircat/version'
require 'dircat/extensions'
require 'dircat/config'
require 'dircat/cat_on_sqlite/simple_cataloger_error'

#
# app
#
require 'dircat/cat_on_sqlite/directory_visitor'
require 'dircat/cat_on_sqlite/cat_on_sqlite'
