require 'optparse'
require 'dircat'

module DirCat

  class DirCatCmp

    def self.run
      self.new.parse_args( ARGV )
    end

    def parse_args(args)
      options = {}
      opts = OptionParser.new
      opts.banner = "Usage: example.rb [options]"

      opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        options[:verbose] = v
      end
      rest = opts.parse( args )

      # p options
      # p ARGV

      if rest.length < 1
        puts "inserire il nome di due directory da confrontare"
        return
      end

      dirname1 = rest[0]
      dirname2 = rest[1] if rest[1]

      if dirname2
        twoset( dirname1, dirname2 )
        return
      end

      if dirname1
        oneset( dirname1 )
        return
      end
    end

    def oneset( dirname )
      puts "build set"
      s = DirCat.loadfromdir(dirname)
      # s.pr
      puts s.to_yaml
    end

    def twoset( dirname1, dirname2 )
      puts "build first set"
      s1 = DirCat.loadfromdir(dirname1)

      puts "build second set"
      s2 = DirCat.loadfromdir(dirname2)

      puts "build difference"
      s3 = s1 - s2

      s3.pr
    end
  end
end
