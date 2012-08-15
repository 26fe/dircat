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
