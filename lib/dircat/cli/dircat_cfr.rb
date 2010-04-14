require 'optparse'
require 'dircat'

module DirCat

  #
  #
  #
  class DirCatCfr

    def self.run
      return self.new.parse_args( ARGV )
    end

    def parse_args( args )
      options = {}
      opts = OptionParser.new
      opts.banner =
        "Usage: dircat_cfr.rb [options] <filedircat1> <filedircat2>\n\n" +
        "fa la differenza fra il primo catalog e il secondo\n" +
        "<filedircat1> - <filedircat2>\n" +
        "e stampa sull'output con un formato\n"

      opts.on("-h", "--help", "Print this message") do
        puts opts
        return 0
      end

      opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        options[:verbose] = v
      end

      opts.on("-f FORMAT", "--fmt FORMAT", "formato") do |v|
        options[:fmt] = v
      end
      rest = opts.parse( args )

      # p options
      # p ARGV

      if rest.length < 2
        puts "inserire il nome di due cataloghi da confrontare"
        puts "dircat_cfr -h to print help"
        exit
      end

      cat_filename1 = rest[0]
      cat_filename2 = rest[1]

      puts "build first set"
      s1 = Cat.loadfromfile(cat_filename1)

      puts "build second set"
      s2 = Cat.loadfromfile(cat_filename2)

      puts "build difference"
      s3 = s1 - s2

      case options[:fmt]
      when "simple"
        s3.fmt_simple
      when "ruby"
        s3.fmt_ruby( "." )
      else
        s3.fmt_simple
      end
      return 0
    end
  end
end
