# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

#
# dir1 contains 2 files
#
# dir2 contains 3 files (one more than dir2)
#
# dir3 contains two duplicated files

describe CatOnYamlFile do

  before do
    @data_dir = TEST_DIR
  end

  it "should build catalog from dir1" do
    cat1 = CatOnYamlFile.from_dir(File.join(@data_dir, "dir1"))
    cat1.size.should == 2
    cat1.bytes.should == 4
  end

  it "should load catalog from dir2" do
    cat2 = CatOnYamlFile.from_dir(File.join(@data_dir, "dir2"))
    cat2.size.should == 3
    cat2.bytes.should == 6
  end

  it "(dir1 - dir2): the difference from dir1 and dir2 is empty" do
    cat1 = CatOnYamlFile.from_dir(File.join(@data_dir, "dir1"))
    cat2 = CatOnYamlFile.from_dir(File.join(@data_dir, "dir2"))
    # dir1 contains all the files in dir2
    cat_diff = cat1 - cat2
    cat_diff.size.should == 0
  end

  it "(dir2 - dir1): the difference from dir2 and dir1 is a file" do
    cat1 = CatOnYamlFile.from_dir(File.join(@data_dir, "dir1"))
    cat2 = CatOnYamlFile.from_dir(File.join(@data_dir, "dir2"))

    # dir2 contains one file more than dir1
    cat_diff = cat2 - cat1
    cat_diff.size.should == 1
  end

  it "should detect duplicates" do
    cat1 = CatOnYamlFile.from_dir(File.join(@data_dir, "dir3"))
    cat1.duplicates.should have(1).files
  end

  # dir4 has an broken symlink, otherwise is identical to dir1
  it "should build catalog from dir4" do
    cat1 = CatOnYamlFile.from_dir(File.join(@data_dir, "dir4"))
    cat1.size.should == 3
    cat1.bytes.should == 20
  end

  context "save to a file" do
    before do
      @tmp_file = File.join(Dir.tmpdir, "dircat1.yaml")
    end

    after do
      FileUtils.rm(@tmp_file) if File.exist? @tmp_file
    end

    it "saving to a file" do
      cat1 = CatOnYamlFile.from_dir(File.join(@data_dir, "dir1"))
      cat1.save_to(@tmp_file)

      dircat1_bis = CatOnYamlFile.from_file(@tmp_file)
      (cat1 - dircat1_bis).size.should == 0
      (dircat1_bis - cat1).size.should == 0
    end

    it "saving to an non-existent file should raise an exception" do
      cat1 = CatOnYamlFile.from_dir(File.join(@data_dir, "dir1"))
      not_existent_file = File.join(Dir.tmpdir, "not_existent", "dircat1.yaml")
      lambda { cat1.save_to(not_existent_file) }.should raise_exception(DirCatException)
    end
  end

  it "should print a report" do
    cat1 = CatOnYamlFile.from_dir(File.join(@data_dir, "dir1"))
    cat1.size.should == 2
    cat1.bytes.should == 4

    out = capture_out { cat1.fmt_report(:md5, :name, :size) }.out

    str =<<-EOS
+----------------------------------+-----------+------+
| md5                              | name      | size |
+----------------------------------+-----------+------+
| 60b725f10c9c85c70d97880dfe8191b3 | file1.txt | 2    |
| 4124bc0a9335c27f086f24ba207a4912 | file3.txt | 2    |
+----------------------------------+-----------+------+
2 rows in set
    EOS
    out.should == str
  end
end
