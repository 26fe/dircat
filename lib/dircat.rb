
class Dircat
  VERSION = '0.0.1'
end

# stdlib
require 'fileutils'
require 'tmpdir'
require 'yaml'
require 'ostruct'

# dircat
require 'rubygems'
require 'gf_utilities/extension_md5'
require 'gf_utilities/extension_numeric'

require 'dircat/dircat.rb'
require 'dircat/cli/dircat_build.rb'
