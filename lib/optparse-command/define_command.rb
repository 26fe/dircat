module OptParseCommand

  #
  # Helper method to define new command
  #
  # @example
  #   CliMyCommand = CliCommand.define_command("command", "command description") do |cli|
  #     ...
  #     <might access to cli methods as common options>
  #     ...
  #     if run_successful then true else false end
  #   end
  #
  def self.define_command(klass, command_name, description = nil, &block)

    unless block_given?
      raise 'define_command: missing block'
    end

    command = Class.new(Command) do
      define_method('exec') do |main, options,rest|
        block.call(main, options, rest)
      end
    end

    ghost   = class << command;
      self
    end

    ghost.class_eval do
      define_method("command") { command_name }
      define_method("description") { description ? description : "missing description" }
      define_method("usage") { "Usage: #{command_name} [options]" }
    end

    klass.register_command(command)
    command
  end

end
