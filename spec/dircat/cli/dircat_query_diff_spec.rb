require File.expand_path( File.join(File.dirname(__FILE__), "..", "..", "spec_helper") )

describe DirCatDiff do

  before do
    @testdata_dirname         = TEST_DIR
    @certified_output_dirname = File.join( @testdata_dirname, "certified_output" )
  end

  it "should accept -h (help) option" do
    out = with_stdout_captured do
      args = %w{-h}
      DirCatDiff.new.parse_args(args)
    end
    out.should match /Usage:/
  end

  it "should accept --version option" do
    out = with_stdout_captured do
      args = %w{--version}
      DirCatDiff.new.parse_args(args)
    end
    out.should match /#{DirCat::version}/
  end

end
