# -*- coding: utf-8 -*-
module SimpleCataloger

  class Category
    include DataMapper::Resource

    property :id, Serial
    property :name, String

    has n, :tags, :order => [:name]

    def self.order_by_name
      all(:order => [:name])
    end

    def items
      tags.collect { |t| t.items }.flatten
    end
  end

end
