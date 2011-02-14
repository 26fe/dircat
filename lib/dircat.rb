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

gem "treevisitor", "0.2.1"
require 'treevisitor'

#
# dircat
#
module DirCat
  def self.version
    filename = File.join(File.dirname(__FILE__), %w{.. VERSION.yml})
    yaml     = YAML.load_file(filename)
    major    = (yaml['major'] || yaml[:major]).to_i
    minor    = (yaml['minor'] || yaml[:minor]).to_i
    patch    = (yaml['patch'] || yaml[:patch]).to_i
    "#{major}.#{minor}.#{patch}"
  end
end

require 'dircat/extension_md5'
require 'dircat/extension_numeric'

require 'dircat/cat'
require 'dircat/entry'

require 'dircat/cli/cli_dircat'
require 'dircat/cli/command_build'
require 'dircat/cli/command_diff'
require 'dircat/cli/command_query'
