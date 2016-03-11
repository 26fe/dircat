# -*- coding: utf-8 -*-
class CliEx2 < OptParseCommand::CliMain

  def self.command
    "ex2"
  end

  def self.description
    "example of optparse-command gem"
  end

  def self.version
    "0.0.1"
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
    parser = super(options)
    #
    # Logging
    #
    parser.separator ""
    parser.separator "logging options:"
    parser.separator ""

    parser.on("--log FILE", "log #{self.class.command} messages to file") do |v|
      options.logger = v
    end

    #
    # Configuration
    #
    parser.separator ""
    parser.separator "configurations options:"
    parser.separator ""

    str = "file where configuration are defined\n"
    str << (" " * 37) + "(default $HOME/.example/example.yaml)"
    parser.on("--config CONFIG", str) do |config|
      options.config_name = config
    end

    parser.on("--user USER", "user") do |email|
      options.email = email
    end

    parser.on("-a", "--ask-password", "ask password on terminal") do
      options.ask_password = true
    end

    parser.on("--password PASSWORD", "password account") do |password|
      options.password = password if password
    end

    parser.on("--tree", "show command tree") do
      self.class.show_command_tree
      options.exit = true
    end

    parser.separator ""
    parser
  end

end
