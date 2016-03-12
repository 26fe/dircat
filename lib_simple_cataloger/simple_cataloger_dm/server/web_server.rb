# -*- coding: utf-8 -*-
module SimpleCataloger

  class WebServer < Sinatra::Base

    def self.run!(*args)
      options = args.last.is_a?(::Hash) ? args.last : {}
      catalog = options[:catalog]

      catalog.roots.each do |root|
        use Rack::MyStatic,
            :urls => ["/#{File.basename(root)}"],
            :root => File.dirname(root)
        puts "mount #{File.basename(root)} -> #{File.dirname(root)}"
      end

      define_method :catalog do
        catalog
      end
      super(*args)
    end

    # turns on static file serving for Sinatra::Base apps
    enable :static

    server_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'web'))
    set :public, File.join(server_dir, 'public')
    set :views, File.join(server_dir, 'views')

    helpers do
      include Rack::Utils
      alias_method :h, :escape_html
    end

    helpers Sinatra::GroupItems
    helpers Helpers

    get '/app.css' do
      content_type 'text/css', :charset => 'utf-8'
      sass :app
    end

    get "/js/tooltips/tooltips.css" do
      content_type 'text/css', :charset => 'utf-8'
      sass "/js/tooltips/tooltips".to_sym
    end

    get '/' do
      @catalog = catalog
      @items   = Item.all
      order    = params[:o] || "alpha"

      @render  = proc { |item|
        "<a href=\"/item/#{item.id}\" rel=\"#{item.id}\">#{item.name}</a>" +
            if item.rating then
              " (r:#{item.rating})"
            else
              " (r:unrated)"
            end
      }

      case order
        when "alpha"
          @grouped_items = group_items(@items, :group_size => 5)
          @title         = "Films in alphabetical order (c:#{@items.length})"
        when "time"
          @grouped_items = group_items(@items, :group_size => 1, :header => proc { |film| film.added_at })
          @title         = "Films in time added order (c:#{@items.length})"
      end
      haml :items
    end

    get '/item/:id' do
      @catalog       = catalog
      @item          = Item.get(params[:id])
      @grouped_items = group_items(@item.tags, :group_size => 1, :header => proc { |tag| tag.category.name })
      haml :item
    end

    get '/categories' do
      @catalog    = catalog
      @categories = Category.all
      haml :categories
    end

    get "/category/:id" do
      @catalog  = catalog
      @category = Category.get(params[:id])
      haml :category
    end

    get "/tag/:id" do
      @catalog = catalog
      @tag     = Tag.get(params[:id])
      haml :tag
    end

    get "/random" do
      max_peso = Item.inject.each do |f|
        f.peso
      end
      Random.new.rand(0..maxpeso)
    end

    #######################################################################################
    # Ajax

    get '/ajax/ajax_item/:id' do
      @item = Item.get(params[:id])
      haml 'ajax/ajax_item'.to_sym, :layout => false
    end

    post '/ajax/open_folder' do
      dir = params[:dir] || "/"
      system("nautilus", dir)
      "ok"
    end

    post "/ajax/set-category" do
      id            = params[:tag_id]
      category_name = params[:category_name]
      tag           = Tag.get(id.to_i)
      category      = Category.first_or_create(:name => category_name)
      tag.category  = category
      tag.save
      catalog.update_categories
      catalog.write_config
      "ok"
    end

    get '/ajax/ajax_set_flag/:id' do
      @film = Item.get(params[:id])
      if (params[:checked] == "true")
        @film.flagged_at = Time.new
      else
        @film.flagged_at = nil
      end
      @film.save
      "ok"
    end

    #######################################################################################
    # Tests

    get "/test/resize" do
      @catalog = catalog
      haml "/test/resize".to_sym
    end

    get "/test/jquery" do
      @catalog = catalog
      haml "/test/jquery".to_sym
    end

    get "/test/lightbox" do
      @catalog = catalog
      haml "/test/lightbox".to_sym
    end

    get "/test/select" do
      @catalog = catalog
      haml "/test/select".to_sym
    end

    get "/test/protovis" do
      @catalog = catalog
      haml "/test/protovis".to_sym
    end
  end

end
