# -*- coding: utf-8 -*-

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe 'example 1' do

  # load examples
  ex_path = File.realpath(File.join(File.dirname(__FILE__), %w{.. .. examples optparse-command example_1}))
  $:.unshift(ex_path)
  require 'ex1'

  it 'ex1 -h' do
    out = capture_out { CliEx1.run %w{ -h } }.out
    str = <<-EOS

Usage: example [options] [COMMAND [command options]]
To view help and options for a particular command, use 'example COMMAND -h'

common options:

    -h, --help                       show this message
        --version                    show the example version
    -v, --[no-]verbose               run verbosely
    -q, --quiet                      quiet mode as --no-verbose
    -l, --list-commands              list commands
    EOS
    expect(out).to be == str
  end

  it 'ex1 -l' do
    out = capture_out { CliEx1.run %w{ -l } }.out
    str = <<-EOS
example commands are:
  macro1               macro1
  macro2               macro2

For help on a particular command: 'example COMMAND -h'
    EOS
    expect(out).to be == str
  end

  it 'ex1 --version' do
    out = capture_out { CliEx1.run %w{ --version } }.out
    str = <<-EOS
example version 0.0.0
    EOS
    expect(out).to be == str
  end

  it 'ex1 foo' do
    out = capture_out { CliEx1.run %w{ foo } }.out
    str = <<-EOS
unknow command 'foo'
    EOS
    expect(out).to be == str
  end

  it 'ex1 macro' do
    out = capture_out { CliEx1.run %w{macro} }.out
    str = <<-EOS
ambiguous command 'macro' candidates are: macro1, macro2
EOS
    expect(out).to be == str
  end

  it 'ex1 macro1 -h' do
    out = capture_out { CliEx1.run %w{ macro1 -h } }.out
    str = <<-EOS
Usage: macro1 [options]
    -h, --help                       show this message
EOS
    expect(out).to be == str
  end

  it 'ex1 macro1' do
    out = capture_out { CliEx1.run %w{ macro1 arg1 arg2} }.out
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
