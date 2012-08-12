# -*- coding: utf-8 -*-
module SimpleCataloger

  class Image < ActiveRecord::Base
    belongs_to :item # :required => false
    belongs_to :tag # :required => false

    def to_json(*a)
      { :item => if item then
                   item.name
                 else
                   nil
                 end,
        :tag  => if tag then
                   tag.name
                 else
                   nil
                 end,
        :src  => path_from_catalog_root }.to_json(*a)
    end

  end

end
