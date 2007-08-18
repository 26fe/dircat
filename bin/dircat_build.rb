#!/usr/bin/env ruby

$DIRCAT_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..") )
$:.unshift( File.join($DIRCAT_HOME, "lib" ) )

require 'dircat/cli/dircat_build.rb'

DirCatBuild.run
