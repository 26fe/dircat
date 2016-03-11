# -*- coding: utf-8 -*-
module SimpleCataloger
  module Helpers

    def partial(template, *args)
      options = args.extract_options!
      options.merge!(:layout => false)
      if collection = options.delete(:collection) then
        collection.inject([]) do |buffer, member|
          buffer << haml(template, options.merge(
              :layout => false,
              :locals => {template.to_sym => member}
            )
          )
        end.join("\n")
      else
        haml(template, options)
      end
    end

    def partial_erb(template)
      erb template
    end

    def base_url
      if Sinatra::Application.port == 80
        "http://#{Sinatra::Application.host}/"
      else
        "http://#{Sinatra::Application.host}:#{Sinatra::Application.port}/"
      end
    end

    def when_updated(time)
      days = (Time.now - time) / (60 * 60 * 24)
      case days.to_i
      when 0
        'today'
      when 1
        'yesterday'
      else
        "#{sprintf("%i", days) } days ago"
      end
    end

    def gen_url(field, visible_field = nil)
      visible_field ||= field
      pos = request.env['REQUEST_URI'].index "?"
      url = if pos
        request.env['REQUEST_URI'][0...pos]
      else
        request.env['REQUEST_URI']
      end
      "<a href='#{url}?order=#{field}'>#{visible_field}</a>"
    end

    def rfc_3339(timestamp)
      timestamp.strftime("%Y-%m-%dT%H:%M:%SZ")
    end
  end
end
