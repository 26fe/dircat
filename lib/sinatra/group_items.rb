# -*- coding: utf-8 -*-
module Sinatra
  module GroupItems

    #
    # Groups array of objects.
    # Ex.:
    # ar = %{ aaa abc bbb bab }
    #
    #
    def group_items(items, opts = {})
      default_opts          = {:group_size => 10, :header => proc { |c| c.to_s[0, 1].upcase }}
      opts                  = default_opts.merge(opts)
      group_size            = opts[:group_size]
      header                = opts[:header]

      items                 = items.sort_by &header
      items_group_by_header = items.group_by &header

      items_by_headers      = []
      merge_headers         = []
      merge_items           = []

      items_group_by_header.sort.each do |header, items|
        merge_headers << header
        merge_items.concat items
        if merge_items.length >= group_size
          items_by_headers << [merge_headers, merge_items]
          merge_headers = []
          merge_items   = []
        end
      end

      if merge_items.length > 0
        items_by_headers << [merge_headers, merge_items]
      end
      items_by_headers
    end

#    render         => proc { |item|
#      "<a href=\"/item/#{item.id}\" rel=\"#{item.id}\">#{item.to_s}</a>"
#    }
    def group_items_html(grouped_items, options = {})
      default_opts  = {
          :group_nr_cols =>3,
          :item_nr_cols  => 1,
          :css_begin     => 'span-24 last',
          :render        => proc { |item| "<b>#{item.to_s}</b>" }
      }
      options       = default_opts.merge(options)
      title         = options[:title]
      group_nr_cols = options[:group_nr_cols]
      item_nr_cols  = options[:item_nr_cols]
      css_begin     = options[:css_begin]
      render        = options[:render]

      html          = ""
      html << "<h2>#{title}</h2>" if title
      grouped_items.each_with_index do |items_with_headers, items_box_index|
        headers = items_with_headers[0]
        items   = items_with_headers[1]
        html << "<div class='#{css_begin}'>" if (items_box_index % group_nr_cols) == 0
        if (items_box_index % group_nr_cols) == (group_nr_cols - 1)
          html << "<div class='span-8 last'>"
        else
          html << "<div class='span-8'>"
        end

        html << "<h2>"
        html << headers.first.to_s
        html << "- #{headers.last}" if headers.length > 1
        html << "</h2>"

        items.each_with_index do |item, index|
          if (index % (items.length / item_nr_cols + 1)) == 0
            html << "<div class='span-6#{index == ((items.length / item_nr_cols + 1) * (item_nr_cols-1)) ? "last" : ""}'/><ul>"
          end

          html << "<li>"
          html << render.call(item)
          html << "</li>"

          if (index % (items.length / item_nr_cols + 1)) == ((items.length / item_nr_cols + 1) -1)
            html << "</ul></div>"
          end
        end
        html << "</ul></div>" if ((items.length-1) % (items.length / item_nr_cols + 1)) != ((items.length / item_nr_cols + 1) -1)
        html << "</div>"
        html << "</div>" if (items_box_index % group_nr_cols) == (group_nr_cols - 1)
      end

      html
    end
  end # module GroupItems
  helpers GroupItems
end # module Sinatra

