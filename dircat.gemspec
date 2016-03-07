# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dircat/version"

Gem::Specification.new do |gem|

  gem.name = DirCat::NAME
  gem.version = DirCat::VERSION
  gem.platform = Gem::Platform::RUBY

  gem.summary = '
    command line utilities to manage catalogs of directory
    and damn simple cataloger using directory convention
  '

  gem.description = <<-EOS
    command line utilities to manage catalogs of directory

    damn simple catalog based on tagging file name.
    The tag are between bracket.
    For example the filename 'photo [sea][2010][summer]', associate
    with the name photo the tag sea,2010,summer.
  EOS


  gem.authors = %w{ Tokiro }
  gem.email = "tokiro.oyama@gmail.com"
  gem.homepage = "http://github.com/tokiro/dircat"


  #
  # dependencies
  #

  gem.add_runtime_dependency(%q<tree.rb>)
  gem.add_runtime_dependency(%q<optparse-command>)
  gem.add_runtime_dependency(%q<sinatra-group-items>)

  gem.add_runtime_dependency(%q<ansi>, [">= 0"])

  # gem.add_runtime_dependency(%q<data_mapper>, [">= 0"])
  # gem.add_runtime_dependency(%q<dm-sqlite-adapter>, [">= 0"])

  gem.add_runtime_dependency(%q<activerecord>, [">= 0"])
  # gem.add_runtime_dependency(%q<mysql2>, ["<= 0.2"])
  gem.add_runtime_dependency(%q<sqlite3>, [">= 0"])

  gem.add_runtime_dependency(%q<sinatra>, [">= 0"])
  gem.add_runtime_dependency(%q<haml>, [">= 0"])
  gem.add_runtime_dependency(%q<sass>, [">= 0"])
  gem.add_runtime_dependency(%q<json>, [">= 0"])


  gem.add_development_dependency(%q<rake>, ['>= 0'])
  gem.add_development_dependency(%q<yard>, ['>= 0'])
  gem.add_development_dependency(%q<bundler>, ['>= 0'])
  gem.add_development_dependency(%q<rspec>, ['>= 0'])
  gem.add_development_dependency(%q<webrat>, ['>= 0'])
  gem.add_development_dependency(%q<sinatra>, ['>= 0'])
  gem.add_development_dependency(%q<rmagick>, ['>= 0'])
  gem.add_development_dependency(%q<rspec-collection_matchers>, ['>= 0'])

  #
  # bin
  #
  # s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.require_paths = %w{ lib }
  gem.executables = %w{ dircat scat }

  #
  # files
  #
  # s.files = `git ls-files`.split("\n")
  gem.files = %w{LICENSE.txt README.md Rakefile dircat.gemspec}
  gem.extra_rdoc_files = %w{
      LICENSE.txt
      README.md
  }
  gem.files.concat Dir['lib/**/*.rb']
  gem.files.concat Dir['examples/*.rb']
  gem.files.concat Dir['web/**/*']
  gem.files.concat Dir['tasks/*.rake']

  #
  # test files
  #
  # s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.test_files = Dir['spec/**/*.rb']
  gem.test_files.concat Dir['spec/fixtures/**/*']

end
