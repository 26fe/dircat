# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "spec_helper"))

describe CliDirCat do

  before do
    @dir1_dirname             = File.join(TEST_DIR, "dir1")
    @dir2_dirname             = File.join(TEST_DIR, "dir2")
    @certified_output_dirname = File.join(TEST_DIR, "certified_output")
    @tmp_output_dirname       = File.join(TEST_DIR, "tmp")
  end

  context "common args" do
    it "should accept -h (-help) option" do
      out = with_stdout_captured do
        args = %w{-h}
        CliDirCat.new.parse_and_execute(args)
      end
      out.should match /Usage:/
    end

    it "should accept --version option" do
      out = with_stdout_captured do
        args = %w{--version}
        CliDirCat.new.parse_and_execute(args)
      end
      out.should match /#{DirCat::version}/
    end
  end

end
