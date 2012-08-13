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
gem "treevisitor", "0.2.2"
require 'treevisitor'

gem "optparse-command", "0.1.7"
require 'optparse-command'

require 'dm-core'
require 'dm-migrations'

#
# simple catalog
#
require 'simple_cataloger/version'
require 'simple_cataloger/simple_cataloger_error'
require 'simple_cataloger/extensions'

#
# db models
#
require 'simple_cataloger/models/item'
require 'simple_cataloger/models/tag'
require 'simple_cataloger/models/tagging'
require 'simple_cataloger/models/category'
require 'simple_cataloger/models/image'

#
# app
#
require 'simple_cataloger/directory_visitor'
require 'simple_cataloger/catalog'

