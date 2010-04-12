require File.join(File.dirname(__FILE__), "..", "spec_helper")


# dir1 contiene 2 file
# aggiunto un file a dir1
# dir2 contiene 3 file (uno in piu' di dir2)

# dir 3 contiene file duplicati

#
# data/
# |-- dir1
# |   |-- file1.txt
# |   |-- file2.txt
# |   `-- subdir
# |       `-- file3.txt
# `-- dir2
#     |-- file1.txt
#     `-- subdir
#         `-- file3.txt


describe DirCat do

  before do
    @data_dir = TEST_DIR
    @tmp_dir  = File.join( @data_dir, "tmp" )
  end

  it "test_dircat1" do
    dircat1 = DirCat.loadfromdir( File.join(@data_dir, "dir1") )
    dircat1.size.should == 2
    dircat1.bytes.size.should == 8
  end

  it "test_dircat2" do
    dircat2 = DirCat.loadfromdir( File.join(@data_dir, "dir2") )
    dircat2.size.should == 3
    dircat2.bytes.should == 6
  end

  it "test_diff_dir1_dir2" do
    dircat1 = DirCat.loadfromdir( File.join(@data_dir, "dir1") )
    dircat2 = DirCat.loadfromdir( File.join(@data_dir, "dir2") )
    # dir1 contiene tutti i file di dir2
    cat_diff = dircat1 - dircat2
    cat_diff.size.should == 0
  end

  it "test_diff_dir2_dir1" do
    dircat1 = DirCat.loadfromdir( File.join(@data_dir, "dir1") )
    dircat2 = DirCat.loadfromdir( File.join(@data_dir, "dir2") )

    # dir2 contiene un file in piu' di dir1
    cat_diff = dircat2 - dircat1
    cat_diff.size.should == 1
  end

  it "test_dir1_ser" do
    dircat1  = DirCat.loadfromdir( File.join(@data_dir, "dir1") )
    not_existent_file = File.join(@tmp_dir, "not_existent", "dircat1.yaml")
    tmp_file = File.join(@tmp_dir, "dircat1.yaml")

    lambda {dircat1.savetofile( not_existent_file )}.should raise_exception(DirCatException)

    dircat1.savetofile( tmp_file )

    dircat1_bis = DirCat.loadfromfile( tmp_file )
    (dircat1 - dircat1_bis).size.should == 0
    (dircat1_bis - dircat1).size.should == 0

    FileUtils.rm( tmp_file )
  end

end
