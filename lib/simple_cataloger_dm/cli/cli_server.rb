# -*- coding: utf-8 -*-
module SimpleCataloger
  #
  # Build a catalogue starting from a directory
  #
  class CliServer

    def self.run
      return self.new.parse_args( ARGV )
    end

    def parse_args( argv )
      options = { :verbose => true, :force => false }
      opts = OptionParser.new
      opts.banner << " <catalog name>\n"
      opts.banner << "launch a webs server to browse the content of <catalog name>\n";
      opts.banner << "\n"

      opts.on("-h", "--help", "Print this message") do
        puts opts
        return 0
      end

      opts.on("--version", "show the simple catalog version") do
        puts "simple catalog version #{SimpleCatalog::version}"
        return 0
      end

      opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        options[:verbose] = v
      end

      rest = opts.parse(argv)

      if rest.length < 1
        puts "too few arguments"
        puts "-h to print help"
        return 0
      end

      catalog_name = rest[0]
      cat_opts = {}

      #
      # option verbose
      #

      if options.has_key?(:verbose)
        if options[:verbose]
          cat_opts[:verbose_level] = 1
        end
      end

      #
      # main
      #

      catalog = Catalog.new(catalog_name)
      WebServer.run! :host => 'localhost', :port => 9091, :catalog => catalog

      0
    end

  end
end
