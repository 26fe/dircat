$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'dircat'
include DirCat

dir = File.join( File.dirname(__FILE__), "..")

cat  = Cat.loadfromdir( dir )
cat.fmt_report

