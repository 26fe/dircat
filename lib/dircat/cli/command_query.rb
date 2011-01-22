# -*- coding: utf-8 -*-

class CommandQuery < OptParseCommand::CliCommand

  def self.command
    "query"
  end

  def self.description
    "show info about dircat catalogs"
  end

  def self.usage
    "Usage: query [options] <catalog> [<method>]"
  end

  def exec(options, rest)
    if rest.length < 1
      puts "missing catalog!"
      puts "-h to print help"
      return 0
    end

    cat_opts     = {}
    cat_filename = rest[0]
    if !File.exists?(cat_filename) or File.directory?(cat_filename)
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
