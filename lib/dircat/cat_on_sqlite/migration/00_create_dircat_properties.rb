# -*- coding: utf-8 -*-
class CreateDircatProperties < ActiveRecord::Migration
  def self.up
    create_table :dircat_properties do |t|
      t.string :name, :null => false
      t.string :value, :null => false
    end
  end

  def self.down
    drop_table :dircat_properties
  end
end
