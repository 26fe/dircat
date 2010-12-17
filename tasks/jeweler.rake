# -*- coding: utf-8 -*-
#
# jeweler
#
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
    # dependecies
    #
    # gem.add_dependency('treevisitor')
    gem.add_development_dependency "rspec"

    #
    # bin
    #
    gem.executables = %w{ dircat-build dircat-diff dircat-query }

    #
    # files
    #
    gem.files  = %w{LICENSE README.rdoc Rakefile VERSION.yml dircat.gemspec}
    gem.files.concat Dir['lib/**/*.rb']
    gem.files.concat Dir['examples/*.rb']

    #
    # test files
    #
    gem.test_files = Dir['spec/**/*.rb']
    gem.test_files.concat Dir['spec/fixtures/**/*']

    #
    # rubyforge
    #
    # gem.rubyforge_project = 'dircat'
  end

  # Jeweler::RubyforgeTasks.new do |rubyforge|
  #   rubyforge.doc_task = "rdoc"
  # end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end
