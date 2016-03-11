# -*- coding: utf-8 -*-
# std lib
require 'stringio'

#
# rubygems, modify $LOAD_PATH
# uncomment this if you want use Gemfile.lock
#
# require 'rubygems'
# require 'bundler/setup'

$VERBOSE=true
#
# OptParse Command
#
require 'optparse-command'

#
# Capture $stdout and $stderr of a block
#
def capture_out
  old_stdout, old_stderr = $stdout, $stderr
  out, err = StringIO.new, StringIO.new
  $stdout, $stderr = out, err
  begin
    yield
  ensure
    $stdout, $stderr = old_stdout, old_stderr
  end
  OpenStruct.new(:out => out.string, :err => err.string)
end
