require File.expand_path( File.join(File.dirname(__FILE__), "..", "..", "spec_helper") )

describe DirCatBuild do

  before do
    @testdata_dirname         = TEST_DIR
    @dir1_dirname             = File.join( @testdata_dirname, "dir1" )
    @dir2_dirname             = File.join( @testdata_dirname, "dir2" )
    @certified_output_dirname = File.join( @testdata_dirname, "certified_output" )
    @tmp_output_dirname       = File.join( @testdata_dirname, "tmp" )
  end

  it "should accept -h (help) option" do
    out = with_stdout_captured do
      args = %w{-h}
      DirCatBuild.new.parse_args(args)
    end
    out.should match /Usage:/
  end


  it "test_dir1" do
    expect_filename = File.join( @certified_output_dirname, "dircat1.yaml" )
    result_filename = File.join( @tmp_output_dirname,       "dircat1.yaml")

    out = with_stdout_captured do
      args = "-f -o #{result_filename} #{@dir1_dirname}"
      DirCatBuild.new.parse_args( args.split )
    end
    # out.should match /Usage:/

    cat_expect = Cat.new.from_file( expect_filename )
    cat_result = Cat.new.from_file( result_filename )

    (cat_result - cat_result).size.should == 0

    (cat_result - cat_expect).size.should == 0
    (cat_expect - cat_result).size.should == 0

    FileUtils.rm(result_filename)
  end

end
