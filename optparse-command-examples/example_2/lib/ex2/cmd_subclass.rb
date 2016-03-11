# -*- coding: utf-8 -*-
class CmdSubclass < OptParseCommand::CommandWithSubCommand

  CliEx2.register_command(self)

  def self.command
    "subclass"
  end

  def self.description
    "command defined as subclass"
  end

  def self.usage
    "usage of subclass command"
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
    main.options.p_options("main_options")
    options.p_options("command_options")
    puts "arguments: #{rest.join(', ')}"
    true
  end

end
