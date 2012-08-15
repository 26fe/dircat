# -*- coding: utf-8 -*-
module SimpleCataloger

  class CatOnSqlite

    attr_reader :name

    def initialize(name)
      @name = name
      @catalogs_dir = DirCat::Config.user_config_dir

      #
      # path db, config, etc...
      #
      @db_filepath     = File.join(@catalogs_dir, "#{name}.sqlite3")
      @db_log_filepath = File.join(@catalogs_dir, "#{name}.log")
      @config_filepath = File.join(@catalogs_dir, "#{name}.yml")

      #TODO: logger usabile per loggare altri eventi oltre a quelli del db

      database_filename = File.join(File.dirname(__FILE__), %w{database.yml})
      @ar_config        = YAML.load(File.open(database_filename))
      # pp config
      # ActiveRecord::Base.connection.create_database(catalog_dbname)
      # ActiveRecord::Base.establish_connection(config['films_mysql'])
      @ar_config['films_sqlite']['database'] = @db_filepath # File.join( File.dirname(__FILE__), "test.sqlite" )
      @ar_config                             = @ar_config['films_sqlite']
    end

    def open
      ActiveRecord::Base.establish_connection(@ar_config)
      require_models
      self
    end

    #
    # Create a new catalog
    # @param array of directories
    #
    def create(*catalog_roots)
      fs = [@db_filepath, @db_log_filepath, @config_filepath]
      fs.each do |f|
        FileUtils.rm(f) if File.exist?(f)
      end

      if File.exist? @config_filepath
        raise SimpleCatalogerError, "cannot create already existent catalog '#{@name}'"
      end
      @config = {
          :roots   => catalog_roots,
          :ignore  => ['sub', 'subtitles', 'images'],
          :version => DirCat::VERSION
      }
      write_config

      #
      # migrate db
      #
      # TODO: drop tables!
      ActiveRecord::Base.establish_connection(@ar_config)
      ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : false
      migration_dir = File.join(File.dirname(__FILE__), %w{migration})
      unless Dir.exist? migration_dir
        raise "migration dir '#{migration_dir}' not exists"
      end
      ActiveRecord::Migrator.migrate(migration_dir, ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
      require_models
    end

    #
    # Rebuild catalog
    #
    def update
      unless File.exist? @config_filepath
        raise "cannot update catalog #{@name}"
      end
      open
      read_config

      #
      # Initialize tag and categories from config
      #
      if @config[:categories]
        # pp @config[:categories]
        @config[:categories].each_pair do |category, tags|
          # puts category
          cat = Category.find_or_create_by_name(category)
          tags.each do |name|
            tag          = Tag.find_or_create_by_name(name)
            tag.category = cat
            tag.save
          end
        end
      end

      #
      # read catalog root
      #
      @config[:roots].each do |root|
        dtw = TreeRb::DirTreeWalker.new(root)
        dtw.ignore /^\./
        @config[:ignore].each do |i|
          dtw.ignore i
        end
        dtw.visit_file=true
        dtw.run(DirectoryVisitor.new(root))
      end

      #
      # cache rating tag
      #
      rating = Category.find_by_name("rating")
      if rating
        Item.all.each do |item|
          t = item.tags.find_by_category_id(rating.id)
          if t
            item.rating = t.name.to_i
            item.save
          end
        end
      end
    end

    #
    # array of roots
    #
    def roots
      read_config unless @config
      @config[:roots]
    end

    #
    # update config file with tag category list and association from category to tag name,
    # so to not lose the association next time the catalog is rebuilt (updated)
    #
    def load_categories_in_config
      h = { }
      Category.all.each do |category|
        next if %w{rating year unknown}.include?(category.name)
        h[category.name] = category.tags.collect { |tag| tag.name }
      end
      @config[:categories] = h
    end

    def write_config
      File.open(@config_filepath, "w") { |f| f.write @config.to_yaml }
    end

    private

    def read_config
      #noinspection RubyResolve
      @config = YAML.load(File.open(@config_filepath))
    end

    def require_models
      model_dir = File.join(File.dirname(__FILE__), %w{ model })
      unless Dir.exist? model_dir
        raise "model directory '#{model_dir}' not exists"
      end
      Dir[File.join(model_dir, '*.rb')].each do |f|
        # puts f
        require f
      end
    end

  end # class

end # module SimpleCatalog
