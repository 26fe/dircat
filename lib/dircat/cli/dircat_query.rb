module DirCat

  class DirCatQuery

    def self.run
      return self.new.parse_args( ARGV)
    end

    def parse_args( args )
      options = {}
      opts = OptionParser.new
      opts.banner =
        "Usage: dircat-query [options] <filedircat> [<command>]\n" +
        "show info on dircat catalogs\n"

      opts.on("-h", "--help", "Print this message") do
        puts opts
        return 0
      end

      opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        options[:verbose] = v
      end

      rest = opts.parse( args )

      # p options
      # p ARGV

      if rest.length < 1
        puts "missing dir catalog!"
        puts "-h to print help"
        return 0
      end

      cat_opts = {}
      cat_filename = rest[0]

      if rest.length > 1
        command = rest[1]
      else 
        command = "report"
      end

      #
      # option verbose
      #
      if options.has_key?(:verbose)
        if options[:verbose]
          cat_opts[:verbose_level] = 1
        end
      end

      s = Cat.new(cat_opts).from_file( cat_filename )

      puts s.send( command.to_sym )
      return 0
    end
  end
end
