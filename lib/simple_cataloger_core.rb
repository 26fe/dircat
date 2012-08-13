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
require 'treevisitor'

require 'active_record'
# gem 'mysql2', "<= 0.3"
# require 'mysql2'

#
# simple catalog
#
require 'version'
require 'simple_cataloger/core/simple_cataloger_error'
require 'simple_cataloger/core/extensions'

#
# app
#
require 'simple_cataloger/core/directory_visitor'
require 'simple_cataloger/core/catalog'
