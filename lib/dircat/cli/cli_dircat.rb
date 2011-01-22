# -*- coding: utf-8 -*-
class CliDirCat < OptParseCommand::CliMain

  def self.command
    "dircat"
  end

  def self.description
    "Simple set of command to build catalogs of files.\n" +
    "Code https://github.com/tokiro/dircat. Feedback to tokiro.oyama@gmail.com"
  end

  def self.version
    DirCat::version
  end

  def defaults
    OpenStruct.new(
        :verbose => true,
        :force   => false
    )
  end

  def opt_parser(options)
    opt_parser = super(options)
    opt_parser
  end

end
