# -*- coding: utf-8 -*-
class CreateTaggings < ActiveRecord::Migration
  def self.up
    create_table :taggings, :id => false do |t|
      t.integer :item_id
      t.integer :tag_id
    end
  end

  def self.down
    drop_table :taggings
  end
end
