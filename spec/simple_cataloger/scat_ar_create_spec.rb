# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))
include SimpleCataloger

def create_test_catalog
  Catalog.new("test_ar").create

  #
  # category
  #
  actor    = Category.create(:name => "Actor")
  director = Category.create(:name => "Director")

  #
  # tags
  #
  t1       = Tag.create(:name => "Mia Farrow", :category => actor)
  keaton   = Tag.create(:name => "Diane Keaton", :category => actor)

  allen          = Tag.create(:name => "Woody Allen", :category => director)
  d1             = Tag.create(:name => "Fellini", :category => director)
  d2             = Tag.create(:name => "Kurosawa", :category => director)

  #
  # films
  #
  play_again_sam = Item.new(:name => "Play It Again, Sam", :added_at => Time.new, :path => "path", :path_from_catalog_root => "path_from_catalog_root")
  play_again_sam.tags << keaton
  play_again_sam.tags << allen
  play_again_sam.save

  i      = Image.new(:path => "path", :path_from_catalog_root => "path from root")
  i.item = play_again_sam
  i.save

  annie_hall = Item.new(:name => "Annie Hall", :added_at => Time.new, :path => "path", :path_from_catalog_root => "path_from_catalog_root")
  annie_hall.tags << allen
  annie_hall.tags << keaton
  annie_hall.save
  i      = Image.new(:path => "path", :path_from_catalog_root => "path from root")
  i.item = annie_hall
  i.save

  #
  # images
  #


  puts "category"
  Category.all.each do |c|
    puts "\t #{c.name}"
  end

  puts "tag"
  Tag.all.each do |t|
    puts "\t #{t.name} #{t.category.name}"
  end

  puts "items"
  Item.all.each do |i|
    puts "\t #{i.name}"
  end

end

def read_test_catalog
  Catalog.new("./test_ar").open

  puts "category"
  Category.all.each do |c|
    puts "\t #{c.name}"
  end

  Category.find_by_name("Actor").items.each do |i|
    pp i
  end

  #
  # Tags
  #
  puts "\ntag"
  Tag.all.each do |t|
    puts "\t #{t.name} #{t.category.name}"
  end

  puts "\nTag -> Item"
  Tag.find_by_name("Woody Allen").items.each do |i|
    puts "\t #{i}"
  end

  puts "extract"
  dir_name = "Broadway Danny Rose [Woody Allen][Mia Farrow][1984]"
  puts Tag.extract_tags(dir_name)
  puts Tag.extract_name(dir_name)
  Tag.match_category("1984")
  Tag.match_category("1985")

  #
  # Items
  #
  puts "\nitems"
  Item.all.each do |i|
    puts "\t #{i.name}"
    i.images.each do |im|
      puts "\t\t #{im.path}"
    end
  end

  #
  # Images
  #
  puts Image.first.to_json

end


describe Catalog do
  it "should write and read catalog" do
    create_test_catalog
    read_test_catalog
  end
end
