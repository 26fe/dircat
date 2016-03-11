# -*- coding: utf-8 -*-
module OptParseCommand

  # CliMain Driver
  #   parses common options
  #   finds command and instantiate a CliCommand
  #   passes the unparsed parameter to CliCommand
  #   leaves control to CliCommand
  #
  # @example
  #   class CliExample < CliMain
  #     def self.command;     "command"; end
  #     def self.description; "description"; end
  #     def self.version;     "0.0.1"; end
  #     def opt_parser(options)
  #       opt_parser = super(options)
  #       ... add your switch here ...
  #       opt_parser
  #     end
  #   end
  #
  class CliMain

    include Runnable

    class << self
      def inherited(subclass)
        # puts "#{self} was inherited by #{subclass}"
        subclass.instance_eval { include CommandRegister }
      end
    end

    def initialize(options = {})
      @catch_exception = false
    end

    def defaults(options)
      OpenStruct.new(
          :verbose         => true,
          :force           => false,
          :default_logging => true,
          :ask_password    => false
      )
    end

    def option_parser(options)
      OptionParser.new do |parser|
        parser.banner= self.class.description
        parser.separator "Usage: #{self.class.command} [options] [COMMAND [command options]]"
        parser.separator "To view help and options for a particular command, use '#{self.class.command} COMMAND -h'"

        #
        # common options
        #
        parser.separator ''
        parser.separator 'common options:'
        parser.separator ''

        parser.on('-h', '--help', 'show this message') do
          puts parser
          options.exit       = true
          options.exit_value = 0
        end

        parser.on('--version', "show the #{self.class.command} version") do
          puts "#{self.class.command} version #{self.class.version}"
          options.exit       = true
          options.exit_value = 0
        end

        parser.on('-v', '--[no-]verbose', 'run verbosely') do |v|
          options.verbose = v
        end

        parser.on("-q", "--quiet", "quiet mode as --no-verbose") do |v|
          options.verbose = false
        end

        parser.on("-l", "--list-commands", "list commands") do
          puts "#{self.class.command} commands are:"
          commands = self.class.commands.values.sort { |a, b| a.command <=> b.command }
          commands.each do |cmd|
            printf "  %-20s %s\n", cmd.command, cmd.description
          end
          puts ''
          puts "For help on a particular command: '#{self.class.command} COMMAND -h'"
          options.exit       = true
          options.exit_value = 0
        end

        add_common_options(parser)
      end
    end

    def add_common_options(parser)
    end

    attr_reader :options

  end
end
