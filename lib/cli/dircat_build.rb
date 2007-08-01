require 'optparse'
require 'dircat.rb'

#
# DirCatBuild
#

class DirCatBuild

  def self.run
    self.new.parse_args( ARGV )
  end

  def parse_args( argv )

    options = { :verbose => true, :force => false }
    opts = OptionParser.new
    opts.banner = "Usage: example.rb [options]"

    opts.on("-h", "--help", "Print this message") do
      puts opts
      return
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
      options[:output] = v
    end

    rest = opts.parse(argv)

    # p options
    # p ARGV

    if rest.length < 1
      puts "inserire il nome della directory di cui creare il catalogo"
      puts "-h to print help"
      return
    end

    dirname = rest[0]
    dirname = File.expand_path( dirname )

    #
    # option verbose
    #

    if options.has_key?(:verbose)
      if options[:verbose]
        $VERBOSE_LEVEL = 1
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
        puts "File #{filename} exists!!!"
        return
      end
      output = File.open(filename, "w")
    end

    start_datetime = DateTime.now
    s = DirCat.loadfromdir(dirname)
    end_datetime = DateTime.now

    # s.pr
    # f.puts s.to_yaml
    s.savetofile( output )

    if output != $stdout
      output.close
    end
    $stderr.puts s.report
    $stderr.puts "tempo: #{end_datetime - start_datetime}"
  end

end
