# -*- coding: utf-8 -*-
require File.expand_path( File.join(File.dirname(__FILE__), "..", "..", "spec_helper") )

describe CommandDiff do

  it "should accept -h (help) option" do
    out = capture_out { CliDirCat.run %w{diff -h} }.out
    out.should match /Usage:/
  end

end
