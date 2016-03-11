# -*- coding: utf-8 -*-
module OptParseCommand

  module CommandRegister

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      #
      # Add class to the list of command.
      #
      def register_command(base)
        # puts "register_command #{base.to_s}"
        @command_list ||= []
        @command_list << base
      end

      #
      # All defined commands
      #
      def commands
        return @name_to_command if @name_to_command
        @name_to_command = {}
        @command_list.each { |cmd| @name_to_command[cmd.command] = cmd } unless @command_list.nil?
        @name_to_command
      end

      def find_command(command_name)
        commands

        return @name_to_command[command_name] if @name_to_command[command_name]

        candidates = []
        @name_to_command.each_key do |name|
          # puts "try #{name}"
          candidates << name if name =~ /^#{command_name}/
        end
        command = nil
        if candidates.empty?
          puts "unknow command '#{command_name}'"
        elsif candidates.length == 1
          command = @name_to_command[candidates.first]
        elsif candidates.length > 1
          puts "ambiguous command '#{command_name}' candidates are: #{candidates.join(", ")}"
        end
        command
      end

      def show_command_tree
        tree = {}
        tree[self.to_s] = command_tree
        puts tree.to_yaml
      end

      def command_tree
        commands
        return {} unless @name_to_command
        tree = {}
        @name_to_command.each_pair { |name, klass|
          tree["#{name} (#{klass.to_s})"] = if klass.respond_to? :command_tree
                                              klass.command_tree
                                            else
                                              nil
                                            end
        }
        tree
      end

    end # module ClassMethods


    #
    # for top level command (Main) options is nil
    #
    def parse_and_execute(options, argv)
      @options = defaults(options)
      begin
        command_args = option_parser(@options).order(argv)
      rescue OptionParser::AmbiguousOption => e
        puts e.message
        return false
      end
      if @options.exit
        return @options.exit_value.nil? || true
      end

      if command_args.empty?
        puts "missing command try '#{self.class.command} -h' for help"
        return false
      end

      command_name = command_args.first
      command_args = command_args[1..-1]

      command_class = self.class.find_command(command_name)
      return false if command_class.nil?

      command = command_class.new
      command.main = self
      if @catch_exception
        begin
          ret = command.parse_and_execute(@options, command_args)
        rescue
          puts "I am so sorry! Something went wrong! (exception #{$!.to_s})"
          return false
        end
      else
        ret = command.parse_and_execute(@options, command_args)
      end
      ret
    end


  end # module Commands
end
