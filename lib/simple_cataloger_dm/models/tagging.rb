# -*- coding: utf-8 -*-
module SimpleCataloger

  class Tagging
    include DataMapper::Resource
    property :id, Serial
    belongs_to :item
    belongs_to :tag
  end

end # module
