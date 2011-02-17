# -*- coding: utf-8 -*-
#
# std lib
#
require 'fileutils'
require 'tmpdir'
require 'yaml'
require 'ostruct'
require 'optparse'
require 'pp'

#
# rubygems
#
gem "optparse-command", "0.1.5"
require 'optparse-command'

gem "treevisitor", "0.2.2"
require 'treevisitor'

#
# dircat
#
require 'dircat/version'
require 'dircat/extension_md5'
require 'dircat/extension_numeric'

require 'dircat/cat'
require 'dircat/entry'

require 'dircat/cli/cli_dircat'
require 'dircat/cli/command_build'
require 'dircat/cli/command_diff'
require 'dircat/cli/command_query'
