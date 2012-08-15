# -*- coding: utf-8 -*-
class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|

      t.string :md5

      t.string :name, :null => false
      t.string :path, :null => false
      t.string :path_from_catalog_root, :null => false
      t.integer :size, :null => false

      t.date :added_at, :null => false

      t.integer :rating
      t.date :flagged_at
    end
  end

  def self.down
    drop_table :items
  end
end
