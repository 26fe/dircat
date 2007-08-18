$DIRCAT_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..") )
$:.unshift( File.join($DIRCAT_HOME, "lib" ) )
$:.unshift( File.join($DIRCAT_HOME, "test" ) )

require 'tc_dircat.rb'
require 'tc_dircat_build.rb'
