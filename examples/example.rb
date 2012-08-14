$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'dircat'
include DirCat

dir = File.join( File.dirname(__FILE__), "..")

cat  = CatOnYamlFile.from_dir( dir )
cat.fmt_report

