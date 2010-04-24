require File.expand_path( File.join(File.dirname(__FILE__), "..", "spec_helper") )

#
# dir1 contains 2 files
#
# dir2 contains 3 files (one more than dir2)
#
# dir3 contains two duplicated files

describe Cat do

  before do
    @data_dir = TEST_DIR
    @tmp_dir  = File.join( @data_dir, "tmp" )
  end

  it "should build catalog from dir1" do
    cat1 = Cat.from_dir( File.join(@data_dir, "dir1") )
    cat1.size.should == 2
    cat1.bytes.size.should == 8
  end

  it "should load catalog from dir2" do
    cat2 = Cat.from_dir( File.join(@data_dir, "dir2") )
    cat2.size.should == 3
    cat2.bytes.should == 6
  end

  it "(dir1 - dir2) the difference from dir1 and dir2 is empty" do
    cat1 = Cat.from_dir( File.join(@data_dir, "dir1") )
    cat2 = Cat.from_dir( File.join(@data_dir, "dir2") )
    # dir1 contiene tutti i file di dir2
    cat_diff = cat1 - cat2
    cat_diff.size.should == 0
  end

  it "(dir2 - dir1) the difference from dir2 and dir1 is a file" do
    cat1 = Cat.from_dir( File.join(@data_dir, "dir1") )
    cat2 = Cat.from_dir( File.join(@data_dir, "dir2") )

    # dir2 contiene un file in piu' di dir1
    cat_diff = cat2 - cat1
    cat_diff.size.should == 1
  end

  it "saving to an inexistents file shoud raise an exception" do
    cat1  = Cat.from_dir( File.join(@data_dir, "dir1") )

    not_existent_file = File.join(@tmp_dir, "not_existent", "dircat1.yaml")
    lambda {cat1.save_to( not_existent_file )}.should raise_exception(DirCatException)
  end

  it "saving to a file" do
    cat1  = Cat.from_dir( File.join(@data_dir, "dir1") )
    tmp_file = File.join(@tmp_dir, "dircat1.yaml")
    cat1.save_to( tmp_file )

    dircat1_bis = Cat.from_file( tmp_file )
    (cat1 - dircat1_bis).size.should == 0
    (dircat1_bis - cat1).size.should == 0

    FileUtils.rm( tmp_file )
  end


  it "should detect duplicates" do
    cat1  = Cat.from_dir( File.join(@data_dir, "dir3") )
    cat1.duplicates.should have(1).files
  end

end
