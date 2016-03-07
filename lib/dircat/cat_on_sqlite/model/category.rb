# -*- coding: utf-8 -*-
module SimpleCataloger

  class Category < ActiveRecord::Base
    scope :order_by_name, -> { order('name') }
    has_many :tags, -> { order 'name' }

    # tried following but it didn't work
    # has_many :items, :through => :tags
    #
    def items
      tags.collect { |t| t.items }.flatten
    end
  end

end
