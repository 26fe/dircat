# -*- coding: utf-8 -*-
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|

    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    gem.name = "dircat"
    gem.summary = "command line utilites to manage catalogs of directory"
    gem.description = %Q{
      command line utilites to manage catalogs of directory
    }
    gem.authors = ["Tokiro"]
    gem.email = "tokiro.oyama@gmail.com"
    gem.homepage = "http://github.com/tokiro/dircat"

    #
    # dependencies, automatically loaded from Gemfile
    #

    #
    # bin
    #
    gem.executables = %w{ dircat }

    #
    # files
    #
    gem.files  = %w{LICENSE.txt README.md Rakefile VERSION.yml dircat.gemspec .gemtest}
    gem.files.concat Dir['lib/**/*.rb']
    gem.files.concat Dir['examples/*.rb']
    gem.files.concat Dir['tasks/*.rake']

    #
    # test files
    #
    gem.test_files = Dir['spec/**/*.rb']
    gem.test_files.concat Dir['spec/fixtures/**/*']

  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end
