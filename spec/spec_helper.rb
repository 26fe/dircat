# -*- coding: utf-8 -*-

#
# std lib
#
require "stringio"
require 'ostruct'
require 'tmpdir'

#
# rubygems
#
require 'sinatra'
require 'rack/test'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

require 'rspec'

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'dircat'
require 'dircat_on_sqlite'
require 'dircat_on_sqlite_cli'
include DirCat
include SimpleCataloger

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

