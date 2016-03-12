# -*- coding: utf-8 -*-
module SimpleCataloger
  class CmdList < OptParseCommand::Command

    CliCat.register_command(self)

    def self.command
      "list"
    end

    def self.description
      'list items in catalog'
    end

    def self.usage
      "#{command} <catalog name> <directory>\n" +
      "Create a catalog with name <catalog name> starting from structure of <directory>"
    end

    def defaults(options)
      options.force = false
      options
    end

    def option_parser(options)
      parser = super(options)
      parser
    end

    def exec(main, options, rest)
      if rest.length < 1
        puts "too few arguments"
        puts "-h to print help"
        return 0
      end

      catalog_name = rest[0]
      cat_opts = {}

#      begin
        catalog = CatOnSqlite.new(catalog_name).open
        puts "contains of '#{catalog.name}'"
        puts "categories"
        Category.all.each do |c|
          puts "\t #{c.name}"
        end

        # Category.find_by_name("Actor").items.each do |i|
        #   pp i
        # end

        #
        # Tags
        #
        puts "tags"
        Tag.all.each do |t|
          puts "\t #{t.name} (category: #{t.category.name})"
        end

        puts "items"
        Item.all.each do |f|
          puts "\t #{f.name}"
        end
#      rescue  e
#        puts e.message
#      end

      0
    end

  end
end
