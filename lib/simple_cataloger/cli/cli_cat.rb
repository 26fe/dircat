# -*- coding: utf-8 -*-
class CliCat < OptParseCommand::CliMain

  def self.command
    "simple_cataloger"
  end

  def self.description
    "description"
  end

  def self.version
    SimpleCataloger::VERSION
  end

#  def defaults(options)
#    OpenStruct.new(
#    )
#  end

#  def option_parser(options)
#    super(options)
#  end

end
