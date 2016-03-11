# -*- coding: utf-8 -*-
cwd = File.expand_path(File.join(File.dirname(__FILE__), %w{ .. lib}))
$:.unshift(cwd) unless $:.include?(cwd)

require 'optparse-command'
require 'optparse-command/extensions_open_struct'

CliEx1  = OptParseCommand::define_main('example')

OptParseCommand::define_command(CliEx1, 'macro1', 'macro1') do |main, options, rest|
  puts 'in exec'
  main.options.p_options("main_options")
  options.p_options('command_options')
  puts "arguments: #{rest.join(', ')}"
  true
end

OptParseCommand::define_command(CliEx1, "macro2", "macro2") do |main, options, rest|
  puts "in exec"
  main.options.p_options("main_options")
  options.p_options("command_options")
  puts "arguments: #{rest.join(', ')}"
  true
end

if __FILE__ == $0
  CliEx1.run!
end

