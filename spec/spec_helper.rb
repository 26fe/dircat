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
#require 'rubygems'


require 'sinatra'
require 'rack/test'
# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

require 'rspec'
#require 'rspec/autorun'
#require 'rspec/interop/test'

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
# $LOAD_PATH.unshift(File.dirname(__FILE__))
# $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'dircat'
require 'simple_cataloger_core'
require 'simple_cataloger_cli'
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

