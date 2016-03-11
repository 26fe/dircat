require 'optparse'
require 'yaml'

module Register
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def register(klass_command)
      cmd_name = klass_command.command
      puts "register #{self} <- #{cmd_name}"
      @name_to_command ||= {}
      @name_to_command[cmd_name] = klass_command
    end

    def find_command(cmd_name)
      puts "#{self.class}::find_command(#{cmd_name})"
      @name_to_command[cmd_name].new
    end

    def show_command_tree
      tree = {}
      tree[self.to_s] = command_tree
      puts tree.to_yaml
    end

    def command_tree
      return {} unless @name_to_command
      tree = {}
      @name_to_command.each_pair { |name, klass|
        tree["#{name} (#{klass.to_s})"] = if klass.respond_to? :command_tree
                                            klass.command_tree
                                          else
                                            {}
                                          end
      }
      tree
    end

  end
end

class Main
  def self.inherited(subclass)
    puts "#{self} was inherited by #{subclass}"
    subclass.instance_eval { include Register }
  end

  def self.run!
    new.run(ARGV)
  end

  def default_options
    {}
  end

  def run(argv)
    puts '*'*10
    puts "#{self.class}::run: #{argv.join(" ")}"
    options = default_options
    rest = options_parser(options).parse(argv)
    return true if options[:exit]
    self.class.find_command(argv[0]).run(rest)
  end
end

class CmdWithSubCommand
  def self.inherited(subclass)
    subclass.instance_eval { include Register }
  end

  def run(argv)
    options_parser
    self.class.find_command(argv[1]).run(argv)
  end
end

class Cmd
  def run(argv)
    options_parser
    exec
  end
end

##############################################################

class MyMain < Main
  def options_parser(options)
    puts "#{self.class}::parser_options"

    parser = OptionParser.new
    parser.on("-h", "--help", "show this message") do
      puts parser
      options[:exit] = true
    end
    parser
  end
end

class Cmd1 < CmdWithSubCommand
  def self.command
    "cmd1"
  end

  MyMain.register(self)

  def options_parser
    puts "#{self.class}::parser_options"
  end
end

class Cmd2 < CmdWithSubCommand
  def self.command
    "cmd2"
  end

  MyMain.register(self)

  def options_parser
    puts "#{self.class}::parser_options"
  end
end

class Cmd3 < CmdWithSubCommand
  def self.command
    "cmd3"
  end

  MyMain.register(self)

  def options_parser
    puts "#{self.class}::parser_options"
  end
end

class Cmd1Cmd1 < Cmd
  def self.command
    "cmd1cmd1"
  end

  Cmd1.register(self)

  def options_parser
    puts "#{self.class}::parser_options"
  end

  def exec
    puts "#{self.class}::exec"
  end
end

class Cmd2Cmd1 < Cmd
  def self.command
    "cmd2cmd1"
  end

  Cmd2.register(self)

  def options_parser
    puts "#{self.class}::parser_options"
  end

  def exec
    puts "#{self.class}::exec"
  end
end

class Cmd2Cmd2 < Cmd
  def self.command
    "cmd2cmd2"
  end

  Cmd2.register(self)

  def options_parser
    puts "#{self.class}::parser_options"
  end

  def exec
    puts "#{self.class}::exec"
  end
end

MyMain.show_command_tree
MyMain.run!


#class MyMain
#  include Main
#end
#
#class Cmd1 < MyMain
#  include WithCommands
#end
#
#class Cmd1Cmd1 < Cmd1
#  include Command
#end

