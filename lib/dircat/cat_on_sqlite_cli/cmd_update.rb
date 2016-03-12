# -*- coding: utf-8 -*-

include SimpleCataloger

module SimpleCataloger
  class CmdUpdate < OptParseCommand::Command

    CliCat.register_command(self)

    def self.command
      "update"
    end

    def self.description
      'update the content of catalog'
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

      catalog = CatOnSqlite.new(catalog_name)
      catalog.update

      0
    end

  end
end
