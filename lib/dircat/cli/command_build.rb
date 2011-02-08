# -*- coding: utf-8 -*-

#
# Build a catalogue starting from a directory
#
class CommandBuild < OptParseCommand::CliCommand

  def self.command
    "build"
  end

  def self.description
    "Build a catalogue starting from a directory"
  end

  def self.usage
    "Usage: dircat build [options]"
  end

  def defaults(options)
    options.force = false
  end

  def option_parser(options)
    parser = super(options)
    parser.on("-f", "--force", "force write on existent file") do |v|
      options.force = true
    end

    parser.on("-o [FILE]", "--output [FILE]", String) do |v|
      if options.output
        puts "only one file of output can be used"
        options.exit = true
      end
      options.output = v
    end

    parser
  end

  def exec(main, options, rest)
    if rest.length < 1
      $stderr.puts "directory (from which build catalog) is missing"
      $stderr.puts "-h to print help"
      return false
    end

    dirname  = rest[0]
    dirname  = File.expand_path(dirname)
    cat_opts = {}

    if not FileTest.directory?(dirname)
      $stderr.puts "'#{dirname}' not exists or is not a directory"
      return 0
    end

    #
    # option verbose
    #

    if options.verbose
      cat_opts[:verbose_level] = 1
    end

    #
    # option: output, force
    #
    output = $stdout
    if options.output
      filename = options.output
    else
      filename = "cat_" + File.basename(dirname) + "_" + Date.today.strftime("%Y%m%d") + ".yaml"
    end
    if File.exist?(filename) and not options.force
      $stderr.puts "catalog '#{filename}' exists use --force or -f to overwrite"
      return 0
    end

    output     = File.open(filename, "w")
    start_time = Time.now
    s          = Cat.from_dir(dirname)
    end_time   = Time.now
    s.save_to(output)

    if output != $stdout
      output.close
    end
    $stderr.puts s.report
    $stderr.puts "elapsed: #{end_time - start_time}"
    $stderr.puts "written to #{filename}" if output != $stdout

    true
  end

end
