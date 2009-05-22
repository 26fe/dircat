$DIRCAT_HOME = File.expand_path( File.join( File.dirname( __FILE__), "..", "..") )
$:.unshift( File.join($DIRCAT_HOME, "lib" ) )

require 'test/unit'
require 'dircat/dircat.rb'

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


class TC_DirCat < Test::Unit::TestCase

  def setup
    @data_dir = File.join($DIRCAT_HOME, "test", "dircat", "data")
    @tmp_dir  = File.join( @data_dir, "tmp" )
  end

  def teardown
  end

  def test_dircat1
    dircat1 = DirCat.loadfromdir( File.join(@data_dir, "dir1") )
    assert_equal(2, dircat1.size )
    assert_equal(4, dircat1.bytes )
  end

  def test_dircat2
    dircat2 = DirCat.loadfromdir( File.join(@data_dir, "dir2") )
    assert_equal(3, dircat2.size )
    assert_equal(6, dircat2.bytes )
  end

  def test_diff_dir1_dir2
    dircat1 = DirCat.loadfromdir( File.join(@data_dir, "dir1") )
    dircat2 = DirCat.loadfromdir( File.join(@data_dir, "dir2") )
    # dir1 contiene tutti i file di dir2
    cat_diff = dircat1 - dircat2
    assert_equal(0, cat_diff.size)
  end

  def test_diff_dir2_dir1
    dircat1 = DirCat.loadfromdir( File.join(@data_dir, "dir1") )
    dircat2 = DirCat.loadfromdir( File.join(@data_dir, "dir2") )

    # dir2 contiene un file in piu' di dir1
    cat_diff = dircat2 - dircat1
    assert_equal(1, cat_diff.size)
  end

  def test_dir1_ser
    dircat1  = DirCat.loadfromdir( File.join(@data_dir, "dir1") )
    not_existent_file = File.join(@tmp_dir, "not_existent", "dircat1.yaml")
    tmp_file = File.join(@tmp_dir, "dircat1.yaml")

    assert_raise DirCatException do
      dircat1.savetofile( not_existent_file )
    end

    dircat1.savetofile( tmp_file )

    dircat1_bis = DirCat.loadfromfile( tmp_file )
    assert_equal( 0, (dircat1 - dircat1_bis).size )
    assert_equal( 0, (dircat1_bis - dircat1).size )
  end

end