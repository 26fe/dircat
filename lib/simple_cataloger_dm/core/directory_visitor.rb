module SimpleCataloger

  #
  # Find directory without subdirectories
  #
  class DirectoryVisitor

    def initialize(catalog_root)
      super
      @stack        = []
      @files        = []
      @nr           = 0
      @catalog_root = catalog_root
    end

    def enter_node(pathname)
      # each directory is associated to a number,
      # so when exit_tree_node is called and the number @nr is not increased
      # the directory doesn't have subdirectories
      @nr     += 1

      dirname = File.basename(pathname)
      tags    = Tag.extract_tags(dirname)
      tags = tags.concat(@stack.last.tags).uniq unless @stack.empty?
      info   = OpenStruct.new(:nr => @nr, :pathname => pathname, :tags => tags, :name => Tag.extract_name(dirname))

      @files = []
      @stack.push(info)
    end

    def exit_node(pathname)
      info = @stack.pop

      if info.nr == @nr
        # this directory doesn't have subdirectories
        name    = info.name
        tag_names    = info.tags
        puts name
        # pp tags

        # every name must be unique, two films cannot have the some name
        if Item.first( :name => name )
          raise "item #{name} is not unique path #{pathname}"
        end

        item    = Item.create(
            :name                   => name,
            :added_at               => File.lstat(pathname).ctime,
            :path                   => pathname,
            :path_from_catalog_root => pathname[File.dirname(@catalog_root).length..-1]
        )

        #
        # Associate item and tags
        #
        unknown = Category.first_or_create(:name => "unknown")
        tag_names.each do |tag_name|
          tag = Tag.first(:name => tag_name)
          unless tag
            tag = Tag.match_category(tag_name)
            unless tag
              tag = Tag.first_or_create(
                  :name     => tag_name,
                  :category => unknown
              )
            end
          end
          Tagging.first_or_create(:item=>item, :tag=> tag)
        end

        #
        # Searches images
        #
        @files.each do |pathname|
          next unless pathname.match /(jpg|jpeg)$/

          image = Image.first_or_create(
              :path                   => pathname,
              :path_from_catalog_root => pathname[File.dirname(@catalog_root).length..-1]
          )
          item.images << image

          filename = File.basename(pathname)
          tag_names     = Tag.extract_tags(filename)
          tag_names.each do |tag_name|
            tag = Tag.first(:name => tag_name)
            if tag
              tag.images << image
              tag.save
            else
              puts "WARNING: tag '#{tag_name}' not found"
            end
          end
        end
        item.save
      end
    end


    #
    # called when visit leaf node
    #
    def visit_leaf(pathname)
      @files << pathname
    end
  end # class
end # module SimpleCataloger
