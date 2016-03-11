# -*- coding: utf-8 -*-
class CmdSubclassSubCmd < OptParseCommand::Command

  CmdSubclass.register_command(self)

  def self.command
    "subcmd"
  end

  def self.description
    "subcommand"
  end

  def self.usage
    "usage of subcommand"
  end

  def defaults(options)
    options.force = false
    options
  end

  def option_parser(options)
    parser = super(options)
    parser.on("-f", "--force", "behaviour like a bull") do
      options.force = true
    end
    parser
  end

  def exec(main, options, rest)
    puts "in exec"
    # main.options.p_options("main_options")
    options.p_options("command_options")
    puts "arguments: #{rest.join(', ')}"
    true
  end

end
