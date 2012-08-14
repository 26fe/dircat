# -*- coding: utf-8 -*-
class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name, :null => false
      t.integer :category_id
    end
  end

  def self.down
    drop_table :tags
  end
end
