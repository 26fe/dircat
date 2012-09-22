# -*- coding: utf-8 -*-
module SimpleCataloger

  class Item < ActiveRecord::Base
    has_many :taggings
    has_many :tags, :through => :taggings
    has_many :images

    def to_s
      name
    end

    def peso
      1
    end

  end

end


## -*- coding: utf-8 -*-
#module SimpleCataloger
#
#  class Item
#    include DataMapper::Resource
#    property :id, Serial
#    property :name, String
#
#    property :added_at, Date
#    property :path, String
#    property :path_from_catalog_root, String
#    property :rating, Integer
#    property :flagged_at, Date
#
#    has n, :taggings
#    has n, :tags, :through => :taggings
#    has n, :images
#
#    def to_s
#      @name
#    end
#  end
#
#end
