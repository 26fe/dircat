# -*- coding: utf-8 -*-

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe 'report' do

  it 'simple report' do
    o1 = OpenStruct.new :a => 1, :b => 2
    o2 = OpenStruct.new :a => 2, :b => 4
    out = capture_out { OptParseCommand::report([o1, o2], :a, :b) }.out
    str = <<-EOS
+---+---+
| a | b |
+---+---+
| 1 | 2 |
| 2 | 4 |
+---+---+
2 rows in set
EOS
    expect(out).to be == str
  end

end
