# -*- coding: utf-8 -*-
module SimpleCataloger
  class CmdCreate < OptParseCommand::Command

    CliCat.register_command(self)

    def self.command
      "create"
    end

    def self.description
      "create a catalog"
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
      if rest.length < 2
        puts "too few arguments"
        puts "-h to print help"
        return 0
      end
      catalog_name = rest[0]
      catalog_dirname = rest[1]
      catalog_dirname = File.expand_path(catalog_dirname)

      if not FileTest.directory?(catalog_dirname)
        puts "'#{catalog_dirname}' not exists or is not a directory"
        return 0
      end

      begin
        catalog = SimpleCataloger::CatOnSqlite.new(catalog_name)
        catalog.create(catalog_dirname)
        catalog.update
      rescue SimpleCataloger::SimpleCatalogerError => e
        puts e.message
      end
      0
    end

  end
end
