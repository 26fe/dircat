require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe DirCat do

  before do
    @testdata_dirname         = TEST_DIR
    @dir1_dirname             = File.join( @testdata_dirname, "dir1" )
    @dir2_dirname             = File.join( @testdata_dirname, "dir2" )
    @certified_output_dirname = File.join( @testdata_dirname, "certified_output" )
    @tmp_output_dirname       = File.join( @testdata_dirname, "tmp" )
  end

  it "test_help" do
    args = "-h"
    DirCatBuild.new.parse_args( args.split )
  end

  it "test_dir1" do
    expect_filename = File.join( @certified_output_dirname, "dircat1.yaml" )
    result_filename = File.join( @tmp_output_dirname,       "dircat1.yaml")
    args = "-f -o #{result_filename} #{@dir1_dirname}"
    DirCatBuild.new.parse_args( args.split )

    cat_expect = DirCat.loadfromfile( expect_filename )
    cat_result = DirCat.loadfromfile( result_filename )

    (cat_result - cat_result).size.should == 0

    (cat_result - cat_expect).size.should == 0
    (cat_expect - cat_result).size.should == 0

    FileUtils.rm(result_filename)
  end

end
