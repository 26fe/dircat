# -*- coding: utf-8 -*-

class CliDirCat < CliMain

  def self.command
    "dircat"
  end

  def self.description
    "Simple set of command to build catalogs of files."
  end

  def self.version
    puts DirCat::version
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
