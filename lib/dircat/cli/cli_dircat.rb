# -*- coding: utf-8 -*-
module DirCat

  class CliDirCat < OptParseCommand::CliMain

    def self.command
      "dircat"
    end

    def self.description
      "Simple set of command to build catalogs of files.\n" +
          "Code https://github.com/tokiro/dircat. Feedback to tokiro.oyama@gmail.com"
    end

    def self.version
      DirCat::VERSION
    end

    def defaults
      OpenStruct.new(
          :verbose => true,
          :force   => false
      )
    end

  end

end
