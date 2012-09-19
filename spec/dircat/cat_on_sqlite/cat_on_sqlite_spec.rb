# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "spec_helper"))
include SimpleCataloger

describe CatOnSqlite do
  it "should write and read catalog" do

    TestCatalogHelper.create_test_catalog
    filename = File.join(TMP_DIR, "test_ar")
    CatOnSqlite.new(filename).open

    Category.all.map(&:name).should == %w(Actor Director)


    Category.find_by_name("Actor").tags.map(&:name).should == ["Diane Keaton", "Mia Farrow"]
    Category.find_by_name("Director").tags.map(&:name).should == ["Fellini", "Kurosawa", "Woody Allen"]
    Tag.all.map(&:name).should == ["Mia Farrow", "Diane Keaton", "Woody Allen", "Fellini", "Kurosawa"]


    Tag.find_by_name("Woody Allen").category.name == "Director"
    Tag.find_by_name("Mia Farrow").category.name == "Actor"
    Tag.find_by_name("Woody Allen").items.map(&:name).should == ["Annie Hall", "Play It Again, Sam"]

    Item.find_by_name("Annie Hall").images.map(&:path).should == ['path']
    Item.find_by_name("Annie Hall").images.first.to_json.should == "{\"item\":\"Annie Hall\",\"tag\":null,\"src\":\"path from root\"}"
  end

  it "should extract tag from directory name" do

    TestCatalogHelper.create_test_catalog
    filename = File.join(TMP_DIR, "test_ar")
    CatOnSqlite.new(filename).open

    dir_name = "Broadway Danny Rose [Woody Allen][Mia Farrow][1984]"
    Tag.extract_tags(dir_name).should == ['Woody Allen', 'Mia Farrow', '1984']
    Tag.extract_name(dir_name).should == "Broadway Danny Rose"
    Tag.match_category("1984").name.should == "year"
    Tag.match_category("1985").name.should == "year"
  end

end
