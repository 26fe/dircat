# -*- coding: utf-8 -*-
module SimpleCataloger
  class Catalog

    attr_reader :name

    def initialize(name)
      @name = name

      # find directory where to store catalog data
      home_dir = ENV['HOME'] || ENV['APPDATA']
      if RUBY_PLATFORM =~ /linux/
        catalogs_dir = File.expand_path(File.join(home_dir, ".simple_cataloger"))
      else
        catalogs_dir = File.expand_path(File.join(home_dir, "simple_cataloger"))
      end
      Dir.mkdir(catalogs_dir) unless File.directory?(catalogs_dir)

      db_filepath = File.join(catalogs_dir, "#{name}.sqlite3")
      db_log_filepath = File.join(catalogs_dir, "#{name}.log")
      @config_filepath = File.join(catalogs_dir, "#{name}.yml")
      setup_db(db_filepath, db_log_filepath)
    end

    #
    # Create a new catalog
    # @param array of directories
    #
    def create(*catalog_roots)
      if File.exist? @config_filepath
        raise SimpleCatalogerError, "cannot create already existent catalog '#{@name}'"
      end
      @config = {
          :roots => catalog_roots,
          :ignore => ['sub', 'subtitles', 'images'],
          :version => SimpleCataloger::VERSION
      }
      write_config
      update
    end

    #
    # Rebuild catalog
    #
    def update
      unless File.exist? @config_filepath
        raise "cannot update catalog #{@name}"
      end
      read_config
      #
      # migrate db
      #
      DataMapper.auto_migrate!
      #DataMapper.auto_upgrade!

      #
      # Initialize categories
      #
      if @config[:categories]
        # pp @config[:categories]
        @config[:categories].each_pair do |category, tags|
          # puts category
          cat = Category.first_or_create(:name => category)
          tags.each do |name|
            tag = Tag.first_or_create(:name => name)
            tag.category = cat
            tag.save
          end
        end
      end

      #
      # read catalog root
      #
      @config[:roots].each do |root|
        dtw = TreeVisitor::DirTreeWalker.new(root)
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
      rating = Category.first(:name => "rating")
      if rating
        Item.all.each do |item|
          t = item.tags.find { |t| t.category == rating }
          if t
            item.rating = t.name.to_i
            item.save
          end
        end
      end
    end

    def setup_db(db_path, db_log_filepath)
      #TODO: logger usabile per loggare altri eventi oltre a quelli del db
      DataMapper::Logger.new(db_log_filepath, :debug)
      DataMapper.setup(:default, "sqlite3:#{db_path}")
      DataMapper.finalize
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
    def update_categories
      h = {}
      Category.all.each do |category|
        next if ["rating", "year", "unknown"].include?(category.name)
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

  end # class

end # module SimpleCatalog
