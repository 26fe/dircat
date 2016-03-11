# -*- coding: utf-8 -*-

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))


describe 'example 1' do
  #
  # load examples
  #
  d = File.join(File.dirname(__FILE__), %w{.. .. examples example_2 lib})
  $:.unshift(d) unless $:.include? d
  require 'ex2'

  it 'ex2 -h' do
    out = capture_out { CliEx2.run %w{ -h } }.out
    str = <<-EOS
example of optparse-command gem
Usage: ex2 [options] [COMMAND [command options]]
To view help and options for a particular command, use 'ex2 COMMAND -h'

common options:

    -h, --help                       show this message
        --version                    show the ex2 version
    -v, --[no-]verbose               run verbosely
    -q, --quiet                      quiet mode as --no-verbose
    -l, --list-commands              list commands

logging options:

        --log FILE                   log ex2 messages to file

configurations options:

        --config CONFIG              file where configuration are defined
                                     (default $HOME/.example/example.yaml)
        --user USER                  user
    -a, --ask-password               ask password on terminal
        --password PASSWORD          password account
        --tree                       show command tree

    EOS
    expect(out).to be == str
  end

  it 'ex2 -l' do
    out = capture_out { CliEx2.run %w{ -l } }.out
    str = <<-EOS
ex2 commands are:
  macro                command defined by macro
  subclass             command defined as subclass

For help on a particular command: 'ex2 COMMAND -h'
    EOS
    expect(out).to be == str
  end

  it 'ex2 --tree' do
    out = capture_out { CliEx2.run %w{ --tree } }.out
    out.gsub!(/\s$/,'')
    str = <<-EOS
---
CliEx2:
  macro (CmdMacro):
  subclass (CmdSubclass):
    subcmd (CmdSubclassSubCmd):
    EOS
    expect(out).to be == str.chop
  end

  it 'ex2 --version' do
    out = capture_out { CliEx2.run %w{ --version } }.out
    str = <<-EOS
ex2 version 0.0.1
    EOS
    expect(out).to be == str
  end

  it 'ex2 foo' do
    out = capture_out { CliEx2.run %w{ foo } }.out
    str = <<-EOS
unknow command 'foo'
    EOS
    expect(out).to be == str
  end

  it 'ex2 subclass -h' do
    out = capture_out { CliEx2.run %w{ subclass -h } }.out
    str = <<-EOS
command defined as subclass
usage of subclass command
    -h, --help                       show this message
    -f, --force                      behaviour like a bull
    EOS
    expect(out).to be == str
  end

  it 'ex2 subclass subcmd' do
    out = capture_out { CliEx2.run %w{ subclass subcmd -f arg1 arg2 } }.out
    str = <<-EOS
in exec
command_options
	ask_password: false
	default_logging: true
	force: true
	verbose: true
arguments: arg1, arg2
    EOS
    expect(out).to be == str
  end

  it 'ex2 macro -h' do
    out = capture_out { CliEx2.run %w{ macro -h } }.out
    str = <<-EOS
Usage: macro [options]
    -h, --help                       show this message
    EOS
    expect(out).to be == str
  end

  it 'ex2 macro ' do
    out = capture_out { CliEx2.run %w{ macro arg1 arg2} }.out
    str = <<-EOS
in exec
main_options
	ask_password: false
	default_logging: true
	exit: false
	force: false
	verbose: true
command_options
	ask_password: false
	default_logging: true
	exit: false
	force: false
	verbose: true
arguments: arg1, arg2
    EOS
    expect(out).to be == str
  end

end
