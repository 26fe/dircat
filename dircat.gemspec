# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dircat/version"

Gem::Specification.new do |gem|

  gem.name = "dircat"
  gem.version = DirCat::VERSION
  gem.platform = Gem::Platform::RUBY
  gem.summary = "command line utilities to manage catalogs of directory"
  gem.description = %Q{
    command line utilities to manage catalogs of directory
  }
  gem.authors = ["Tokiro"]
  gem.email = "tokiro.oyama@gmail.com"
  gem.homepage = "http://github.com/tokiro/dircat"


  #
  # dependencies
  #
  gem.add_runtime_dependency(%q<ansi>, [">= 0"])
  gem.add_runtime_dependency(%q<treevisitor>)
  gem.add_runtime_dependency(%q<optparse-command>, ["= 0.1.6"])

  gem.add_development_dependency(%q<rake>, [">= 0"])
  gem.add_development_dependency(%q<yard>, [">= 0"])
  gem.add_development_dependency(%q<bundler>, [">= 0"])
  gem.add_development_dependency(%q<rspec>, [">= 0"])

  #
  # bin
  #
  # s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.require_paths = ["lib"]
  gem.executables = %w{ dircat }

  #
  # files
  #
  # s.files = `git ls-files`.split("\n")
  gem.files = %w{LICENSE.txt README.md Rakefile dircat.gemspec .gemtest}
  gem.extra_rdoc_files = [
      "LICENSE.txt",
      "README.md"
  ]
  gem.files.concat Dir['lib/**/*.rb']
  gem.files.concat Dir['examples/*.rb']
  gem.files.concat Dir['tasks/*.rake']

  #
  # test files
  #
  # s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.test_files = Dir['spec/**/*.rb']
  gem.test_files.concat Dir['spec/fixtures/**/*']

end
