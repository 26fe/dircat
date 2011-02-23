# -*- coding: utf-8 -*-
require "stringio"
require 'ostruct'
require 'tmpdir'

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'dircat'
include DirCat

TEST_DIR = File.expand_path(File.join(File.dirname(__FILE__), "fixtures"))

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
