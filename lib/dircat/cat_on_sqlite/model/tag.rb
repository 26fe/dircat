# -*- coding: utf-8 -*-
module SimpleCataloger

  class Tag < ActiveRecord::Base
    belongs_to :category

    has_many :taggings
    has_many :items, :through => :taggings, :order => "name"
    has_many :images

    ##################################################
    #

    RE_TAG = /\[([^\]]+)\]/

    # extracts tags from directory or file name
    def self.extract_tags(dir_or_file_name)
      tags       = []
      match_data = dir_or_file_name.match(RE_TAG)
      while match_data
        tags << match_data[1]
        match_data = dir_or_file_name.match(RE_TAG, match_data.end(0))
      end
      tags
    end

    def self.extract_name(dir_or_file_name)
      dir_or_file_name.gsub(Tag::RE_TAG, '').strip
    end

    RE_RATING = /^\d$/
    RE_YEAR   = /^\d\d\d\d$/

    MATCHES = [
        [RE_RATING, "rating", proc { |tag_name| tag_name.to_i }],
        [RE_YEAR, "year", proc { |tag_name| tag_name.to_i }]
    ]

    #
    # decode standard tags
    #
    def self.match_category(tag_name)
      MATCHES.each do |re, category_name, convert|
        if re.match tag_name
          category = Category.find_or_create_by_name(category_name)
          tag      = Tag.find_or_create_by_name_and_category_id(
              convert.call(tag_name),
              category.id
          )
          return category
        end
      end
      nil
    end

  end # class Tag

end # module SimpleCatalog
