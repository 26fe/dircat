# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "spec_helper"))

describe CommandBuild do

  before do
    @dir1_dirname             = File.join(TEST_DIR, "dir1")
    @dir2_dirname             = File.join(TEST_DIR, "dir2")
    @certified_output_dirname = File.join(TEST_DIR, "certified_output")
    @tmp_output_dirname       = File.join(TEST_DIR, "tmp")
  end

  it "should accept -h (-help) option" do
    out = capture_out { CliDirCat.run(%w{build -h}) }.out
    out.should match /Usage:/
  end

  it "should not accept more then -o options" do
    out = capture_out { CliDirCat.run("build -f -o filename -o filename1".split) }.out
    out.should match /only one file/
  end


  it "should build a catalog from a directory" do
    expect_filename = File.join(@certified_output_dirname, "dircat1.yaml")
    result_filename = File.join(@tmp_output_dirname, "dircat1.yaml")

    capture_out { CliDirCat.run("build -f -o #{result_filename} #{@dir1_dirname}".split) }

    cat_expect      = Cat.from_file(expect_filename)
    cat_result      = Cat.from_file(result_filename)

    (cat_result - cat_result).size.should == 0

    (cat_result - cat_expect).size.should == 0
    (cat_expect - cat_result).size.should == 0

    FileUtils.rm(result_filename)
  end

end
