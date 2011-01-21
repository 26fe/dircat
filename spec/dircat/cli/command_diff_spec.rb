# -*- coding: utf-8 -*-
require File.expand_path( File.join(File.dirname(__FILE__), "..", "..", "spec_helper") )

describe CommandDiff do

  it "should accept -h (help) option" do
    out = with_stdout_captured do
      args = %w{diff -h}
      CliDirCat.new.parse_and_execute(args)
    end
    out.should match /Usage:/
  end

end
