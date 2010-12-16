require File.expand_path( File.join(File.dirname(__FILE__), "..", "spec_helper") )

describe "MD5" do

  TEST_FILE = File.expand_path( File.join( File.dirname(__FILE__), "..", "..", "lib", "dircat", "extension_md5.rb" ) )

  it "test_simple_md5" do
    file_name = File.join( TEST_FILE )
    MD5.file( file_name ).to_s.should  ==  "8777d9d35da17496e21dcc8a4f9f8191"
  end

end
