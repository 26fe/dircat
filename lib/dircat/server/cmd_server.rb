# -*- coding: utf-8 -*-
module SimpleCataloger

  class CmdServer < OptParseCommand::Command

    CliCat.register_command(self)

    def self.command
      "server"
    end

    def self.description
      'start server'
    end

    def self.usage
      "#{command}  <catalog name>\n" +
      "launch a webs server to browse the content of <catalog name>\n"
    end

    def defaults(options)
      options.force = false
      options
    end

    def option_parser(options)
      super(options)
    end

    def exec(main, options, rest)
      if rest.length < 1
        puts 'too few arguments'
        puts '-h to print help'
        return 0
      end

      catalog_name = rest[0]
      cat_opts     = { }

      #
      # option verbose
      #

#    if options.has_key?(:verbose)
#      if options[:verbose]
#        cat_opts[:verbose_level] = 1
#      end
#    end

      #
      # main
      #

      catalog = SimpleCataloger::CatOnSqlite.new(catalog_name).open
      SimpleCataloger::WebServer.run! :host => 'localhost', :port => 9091, :catalog => catalog

      0
    end

  end
end
