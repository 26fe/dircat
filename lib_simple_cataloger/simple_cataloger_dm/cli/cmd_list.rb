# -*- coding: utf-8 -*-
module SimpleCataloger
  class CmdList < OptParseCommand::Command

    CliCat.register_command(self)

    def self.command
      "list"
    end

    def self.description
      "list items in catalog"
    end

    def self.usage
      "#{command} <catalog name> <directory>"
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

      begin
        catalog = Catalog.new(catalog_name)
        puts "list film contained into '#{catalog.name}'"
        Item.all.each do |f|
          puts f.name
        end
      rescue DataObjects::SyntaxError => e
        puts e.message
      end

      0
    end

  end
end
