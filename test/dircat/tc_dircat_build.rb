$DIRCAT_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..", "..") )
$:.unshift( File.join($DIRCAT_HOME, "lib" ) )

# stdlib
require 'test/unit'

# dircat
require 'dircat/dircat.rb'
require 'dircat/cli/dircat_build.rb'

class TC_DirCatBuild < Test::Unit::TestCase

  def setup
    @testdata_dirname         = File.join( $DIRCAT_HOME, "test_data", "dircat", "data")
    @dir1_dirname             = File.join( @testdata_dirname, "dir1" )
    @dir2_dirname             = File.join( @testdata_dirname, "dir2" )
    @certified_output_dirname = File.join( @testdata_dirname, "certified_output" )
    @tmp_output_dirname       = File.join( @testdata_dirname, "tmp" )
  end

  def test_help
    args = "-h"
    DirCatBuild.new.parse_args( args.split )
  end

  def test_dir1
    expect_filename = File.join( @certified_output_dirname, "dircat1.yaml" )
    result_filename = File.join( @tmp_output_dirname,       "dircat1.yaml")
    args = "-f -o #{result_filename} #{@dir1_dirname}"
    DirCatBuild.new.parse_args( args.split )

    cat_expect = DirCat.loadfromfile( expect_filename )
    cat_result = DirCat.loadfromfile( result_filename )

    assert_equal( 0, (cat_result - cat_result).size )

    assert_equal( 0, (cat_result - cat_expect).size )
    assert_equal( 0, (cat_expect - cat_result).size )

    FileUtils.rm(result_filename)
  end

end
