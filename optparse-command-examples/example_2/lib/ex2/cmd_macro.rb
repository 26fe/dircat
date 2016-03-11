# -*- coding: utf-8 -*-
CmdMacro = OptParseCommand::define_command(CliEx2, "macro", "command defined by macro") do |main, options, rest|
  puts "in exec"
  main.options.p_options("main_options") if main
  options.p_options("command_options")
  puts "arguments: #{rest.join(', ')}"
  true
end
