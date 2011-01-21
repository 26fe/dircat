# -*- coding: utf-8 -*-

require "stringio"
require 'ostruct'

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'dircat'
include DirCat

TEST_DIR = File.expand_path( File.join( File.dirname(__FILE__), "fixtures" ) )

def with_stdout_captured
  old_stdout = $stdout
  out = StringIO.new
  $stdout = out
  begin
    yield
  ensure
    $stdout = old_stdout
  end
  out.string
end
