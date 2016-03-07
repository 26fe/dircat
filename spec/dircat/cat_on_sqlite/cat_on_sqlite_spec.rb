# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'spec_helper'))
include SimpleCataloger

describe CatOnSqlite do
  it 'should write and read catalog' do

    TestCatalogHelper.create_test_catalog
    filename = File.join(TMP_DIR, 'test_ar')
    CatOnSqlite.new(filename).open

    expect(Category.all.map(&:name)).to be == %w(Actor Director)


    expect(Category.find_by_name('Actor').tags.map(&:name)).to be == ["Diane Keaton", "Mia Farrow"]
    expect(Category.find_by_name('Director').tags.map(&:name)).to be == ['Fellini', 'Kurosawa', 'Woody Allen']
    expect(Tag.all.map(&:name)).to be == ["Mia Farrow", 'Diane Keaton', 'Woody Allen', 'Fellini', 'Kurosawa']


    Tag.find_by_name("Woody Allen").category.name == "Director"
    Tag.find_by_name('Mia Farrow').category.name == "Actor"
    expect(Tag.find_by_name('Woody Allen').items.map(&:name)).to be == ['Annie Hall', 'Play It Again, Sam']

    expect(Item.find_by_name('Annie Hall').images.map(&:path)).to be == ['path']
    expect(Item.find_by_name('Annie Hall').images.first.to_json).to be == "{\"item\":\"Annie Hall\",\"tag\":null,\"src\":\"path from root\"}"
  end

  it 'should extract tag from directory name' do

    TestCatalogHelper.create_test_catalog
    filename = File.join(TMP_DIR, "test_ar")
    CatOnSqlite.new(filename).open

    dir_name = "Broadway Danny Rose [Woody Allen][Mia Farrow][1984]"
    expect(Tag.extract_tags(dir_name)).to be == ['Woody Allen', 'Mia Farrow', '1984']
    expect(Tag.extract_name(dir_name)).to be == "Broadway Danny Rose"
    expect(Tag.match_category("1984").name).to be == 'year'
    expect(Tag.match_category("1985").name).to be == 'year'
  end

end
