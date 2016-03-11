# -*- coding: utf-8 -*-
module OptParseCommand

  # Base class for generic command
  #
  # @example
  #   class MyCommand < CliCommand
  #     def self.command;     "command"; end
  #     def self.description; "command description"; end
  #     def self.usage; "Usage: ...."; end
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
  class CommandWithSubCommand

    def self.inherited(subclass)
      # puts "#{self} was inherited by #{subclass}"
      subclass.instance_eval { include CommandRegister }
    end

    attr_accessor :main

    def defaults(options)
      options.exit=false
    end

    def option_parser(options)
      parser       = OptionParser.new
      parser.banner= self.class.description
      parser.separator self.class.usage if self.class.respond_to?(:usage) and self.class.usage
      parser.on('-h', '--help', 'show this message') do
        puts parser
        options.exit = true
      end
      parser
    end

  end # class CliCommand
end
