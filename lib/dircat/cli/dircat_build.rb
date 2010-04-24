module DirCat
  #
  # Build a catalogue starting from a directory
  #
  class DirCatBuild

    def self.run
      return self.new.parse_args( ARGV )
    end

    def parse_args( argv )
      options = { :verbose => true, :force => false }
      opts = OptionParser.new
      opts.banner << "Usage: dircat-build [options]\n"
      opts.banner << "\n"
      opts.banner << "Build a catalogue starting from a directory\n";
      opts.banner << "\n"

      opts.on("-h", "--help", "Print this message") do
        puts opts
        return 0
      end

      opts.on("--version", "show the dircat version") do
        puts "dircat version #{DirCat::version}"
        return 0
      end

      opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        options[:verbose] = v
      end

      opts.on("-q", "--quiet", "quiet mode as --no-verbose") do |v|
        options[:verbose] = false
      end

      opts.on("-f", "--force", "force write on existent file") do |v|
        options[:force] = true
      end

      opts.on("-o [FILE]", "--output [FILE]",String) do |v|
        if options[:output]
          puts "only one file of output can be used"
          return 1
        end
        options[:output] = v
      end

      rest = opts.parse(argv)

      # p options
      # p ARGV

      if rest.length < 1
        puts "directory (from which build catalog) is missing"
        puts "-h to print help"
        return 0
      end

      dirname = rest[0]
      dirname = File.expand_path( dirname )
      cat_opts = {}

      if not FileTest.directory?(dirname)
        puts "'#{dirname}' not exists or is not a directory"
        return 0
      end

      #
      # option verbose
      #

      if options.has_key?(:verbose)
        if options[:verbose]
          cat_opts[:verbose_level] = 1
        end
      end

      #
      # option: output, force
      #
      output = $stdout
      if options.has_key?(:output)
        if options[:output]
          filename = options[:output]
        else
          filename = "cat_" + File.basename( dirname ) + "_" + Date.today.strftime("%Y%m%d") + ".yaml"
        end
        if File.exist?(filename) and not options[:force]
          puts "catalog '#{filename}' exists use --force or -f to overwrite"
          return 0
        end
        output = File.open(filename, "w")
      end

      start_datetime = DateTime.now
      s = Cat.from_dir(dirname)
      end_datetime = DateTime.now

      # s.pr
      # f.puts s.to_yaml
      s.save_to( output )

      if output != $stdout
        output.close
      end
      $stderr.puts s.report
      $stderr.puts "tempo: #{end_datetime - start_datetime}"

      return 0
    end

  end
end
