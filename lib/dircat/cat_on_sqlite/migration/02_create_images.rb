# -*- coding: utf-8 -*-
class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :path, :null => false
      t.string :path_from_catalog_root, :null => false

      t.integer :tag_id
      t.integer :item_id
    end
  end

  def self.down
    drop_table :images
  end
end
