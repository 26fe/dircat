# -*- coding: utf-8 -*-

class CommandQuery < CliCommand

  def self.command
    "query"
  end

  def self.description
    "show info about dircat catalogs"
  end

  def self.usage
    "Usage: dircat-query [options] <filedircat> [<command>]"
  end

  def opt_parser(options)
    opt_parser = super(options)

    opt_parser.on("-o [FILE]", "--output [FILE]", String) do |v|
      if options[:output]
        puts "only one file of output can be used"
        return 1
      end
      options.output = v
    end

    opt_parser.on("-f", "--force", "force write on existent file") do |v|
      options[:force] = true
    end

    opt_parser
  end

  def exec(options, rest)
    if rest.length < 1
      puts "missing catalog!"
      puts "-h to print help"
      return 0
    end

    cat_opts     = {}
    cat_filename = rest[0]
    unless File.exists?(cat_filename)
      puts "first args must be a catalogue"
      return 1
    end

    if rest.length > 1
      command = rest[1]
    else
      command = "report"
    end

    #
    # option verbose
    #
    if options.verbose
      cat_opts[:verbose_level] = 1
    end

    s = Cat.from_file(cat_filename, cat_opts)

    puts s.send(command.to_sym)
    true
  end

end


#module DirCat
#
#  class DirCatQuery
#
#    def self.run
#      return self.new.parse_args( ARGV)
#    end
#
#    def parse_args( args )
#      options = {}
#      opts = OptionParser.new
#      opts.banner =
#        "show info on dircat catalogs\n"
#
#      opts.on("--version", "show the dircat version") do
#        puts "dircat version #{DirCat::version}"
#        return 0
#      end
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
#      rest = opts.parse( args )
#
#      # p options
#      # p ARGV
#
#      if rest.length < 1
#        puts "missing catalog!"
#        puts "-h to print help"
#        return 0
#      end
#
#      cat_opts = {}
#      cat_filename = rest[0]
#      unless File.exists?(cat_filename)
#        puts "first args must be a catalogue"
#        return 1
#      end
#
#      if rest.length > 1
#        command = rest[1]
#      else
#        command = "report"
#      end
#
#      #
#      # option verbose
#      #
#      if options.has_key?(:verbose)
#        if options[:verbose]
#          cat_opts[:verbose_level] = 1
#        end
#      end
#
#      s = Cat.from_file( cat_filename, cat_opts )
#
#      puts s.send( command.to_sym )
#      0
#    end
#  end
#end
