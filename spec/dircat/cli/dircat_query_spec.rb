require File.expand_path( File.join(File.dirname(__FILE__), "..", "..", "spec_helper") )

describe DirCatQuery do

  before do
    @testdata_dirname         = TEST_DIR
    @certified_output_dirname = File.join( @testdata_dirname, "certified_output" )
  end

  it "should accept -h (help) option" do
    out = with_stdout_captured do
      args = %w{-h}
      DirCatQuery.new.parse_args(args)
    end
    out.should match /Usage:/
  end

  it "should accept a catalogs " do
    cat_filename = File.join( @certified_output_dirname, "dircat1.yaml" )
    out = with_stdout_captured do
      args = "#{cat_filename}"
      DirCatQuery.new.parse_args(args.split)
    end
    out.should match /file 2/
    out.should match /Bytes 4/
  end
end
