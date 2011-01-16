# -*- coding: utf-8 -*-

class CommandDiff < CliCommand

  def self.command
    "build"
  end

  def self.description
#    "Usage: dircat_cfr.rb [options] <filedircat1> <filedircat2>\n\n" +
#    "fa la differenza fra il primo catalog e il secondo\n" +
#    "<filedircat1> - <filedircat2>\n" +
#    "e stampa sull'output con un formato\n"
    "Show diff from two catalogs"
  end

  def opt_parser(options)
    opt_parser = super(options)
    opt_parser.on("-f FORMAT", "--fmt FORMAT", "formato") do |v|
      options.format = v
    end
    opt_parser
  end

  def exec(options, rest)
    if rest.length < 2
      puts "you must provide two args (catalogs or directory)"
      puts "-h to print help"
      return false
    end

    cat_filename1 = rest[0]
    cat_filename2 = rest[1]

    if File.exists?( cat_filename1 )
      puts "load catalog #{cat_filename1}"
      s1 = Cat.from_file(cat_filename1)
    elsif File.directory?(cat_filename1)
      puts "build first set from directory #{cat_filename1}"
      s1 = Cat.from_dir(cat_filename1)
    else
      puts "#{cat_filename1} is not a catalog file or directory"
      return 1
    end

    if File.exists?( cat_filename2 )
      puts "load catalog #{cat_filename2}"
      s2 = Cat.from_file(cat_filename2)
    elsif File.directory?(cat_filename2)
      puts "build first set from directory #{cat_filename2}"
      s2 = Cat.from_dir(cat_filename2)
    else
      puts "#{cat_filename2} is not a catalog file or directory"
      return 1
    end

    puts "build difference"
    s3 = s1 - s2

    case options.format
    when "simple"
      s3.fmt_simple
    when "ruby"
      s3.fmt_ruby( "." )
    else
      s3.fmt_simple
    end
    true
  end

end


#module DirCat
#
#  class DirCatDiff
#
#    def self.run
#      return self.new.parse_args( ARGV )
#    end
#
#    def parse_args( args )
#      options = {}
#      opts = OptionParser.new
#      opts.banner =
#        "Usage: dircat_cfr.rb [options] <filedircat1> <filedircat2>\n\n" +
#        "fa la differenza fra il primo catalog e il secondo\n" +
#        "<filedircat1> - <filedircat2>\n" +
#        "e stampa sull'output con un formato\n"
#
#      opts.on("-h", "--help", "Print this message") do
#        puts opts
#        return 0
#      end
#
#      opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
#        options[:verbose] = v
#      end
#
#      opts.on("-f FORMAT", "--fmt FORMAT", "formato") do |v|
#        options[:fmt] = v
#      end
#      rest = opts.parse( args )
#
#      # p options
#      # p ARGV
#
#      if rest.length < 2
#        puts "you must provide two args (catalogs or directory)"
#        puts "dircat_cfr -h to print help"
#        exit
#      end
#
#      cat_filename1 = rest[0]
#      cat_filename2 = rest[1]
#
#      if File.exists?( cat_filename1 )
#        puts "load catalog #{cat_filename1}"
#        s1 = Cat.from_file(cat_filename1)
#      elsif File.directory?(cat_filename1)
#        puts "build first set from directory #{cat_filename1}"
#        s1 = Cat.from_dir(cat_filename1)
#      else
#        puts "#{cat_filename1} is not a catalog file or directory"
#        return 1
#      end
#
#      if File.exists?( cat_filename2 )
#        puts "load catalog #{cat_filename2}"
#        s2 = Cat.from_file(cat_filename2)
#      elsif File.directory?(cat_filename2)
#        puts "build first set from directory #{cat_filename2}"
#        s2 = Cat.from_dir(cat_filename2)
#      else
#        puts "#{cat_filename2} is not a catalog file or directory"
#        return 1
#      end
#
#      puts "build difference"
#      s3 = s1 - s2
#
#      case options[:fmt]
#      when "simple"
#        s3.fmt_simple
#      when "ruby"
#        s3.fmt_ruby( "." )
#      else
#        s3.fmt_simple
#      end
#      0
#    end
#  end
#end
#
