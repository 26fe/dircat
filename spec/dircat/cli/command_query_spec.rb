require File.expand_path( File.join(File.dirname(__FILE__), "..", "..", "spec_helper") )

describe CommandQuery do

  before do
    @certified_output_dirname = File.join( TEST_DIR, "certified_output" )
  end

  it "should accept -h (help) option" do
    out = with_stdout_captured do
      args = %w{query -h}
      CliDirCat.new.parse_and_execute(args)
    end
    out.should match /Usage:/
  end

  it "should show catalogs info" do
    cat_filename = File.join( @certified_output_dirname, "dircat1.yaml" )
    out = with_stdout_captured do
      args = "query #{cat_filename}"
      CliDirCat.new.parse_and_execute(args.split)
    end
    out.should match /file: 2/
    out.should match /Bytes: 4/
  end
end
