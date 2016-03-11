# -*- coding: utf-8 -*-
module OptParseCommand

  # Base class for generic command
  #
  # @example
  #   class MyCommand < CliCommand
  #     def self.command;     "command"; end
  #     def self.description; "command description when list command"; end
  #     def self.usage; "usage when print -h"; end
  #
  #     def initialize(common_args)
  #       ...
  #     end
  #
  #     def parse_and_run(args)
  #        ...
  #       if run_successful then true else false end
  #     end
  #   end
  #
  class Command

    include Runnable

    attr_accessor :main

    def defaults(options)
      options.exit=false
    end

    def option_parser(options)
      parser = OptionParser.new
      if self.class.respond_to?(:usage) and self.class.usage
        parser.banner = self.class.usage
      else
        parser.banner= ''
      end
      parser.on('-h', "--help", "show this message") do
        puts parser
        options.exit = true
      end
      parser
    end

    def parse_and_execute(options, argv)
      defaults(options)

      begin
        rest = option_parser(options).parse(argv)
      rescue OptionParser::InvalidOption => e
        $stderr.puts e.to_s + " for #{self.class.command}"
        return false
      end
      return false if options.exit
      exec(main, options, rest)
    end

  end # class CliCommand
end
