#
# std lib
#
require 'pp'

#
# optparse-command
#
cwd = File.expand_path(File.join(File.dirname(__FILE__), %w{ .. .. .. lib}))
$:.unshift(cwd) unless $:.include?(cwd)
require 'optparse-command'
require 'optparse-command/extensions_open_struct'
#
# example
#

require 'ex2/cli_ex2'
require 'ex2/cmd_macro'
require 'ex2/cmd_subclass'
require 'ex2/cmd_subclass_sub_cmd'

