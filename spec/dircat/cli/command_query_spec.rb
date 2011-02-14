# -*- coding: utf-8 -*-
require File.expand_path( File.join(File.dirname(__FILE__), "..", "..", "spec_helper") )

describe CommandQuery do

  before do
    @certified_output_dirname = File.join( TEST_DIR, "certified_output" )
  end

  it "should accept -h (help) option" do
    out = capture_out { CliDirCat.run %w{query -h} }.out
    out.should match /Usage:/
  end

  it "should show catalogs info" do
    cat_filename = File.join( @certified_output_dirname, "dircat1.yaml" )
    out = capture_out { CliDirCat.run "query #{cat_filename}".split }.out
    out.should match /file: 2/
    out.should match /Bytes: 4/
  end
end
