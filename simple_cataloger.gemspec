# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_cataloger_ar/version"

Gem::Specification.new do |gem|
  gem.name        = "simple_cataloger"
  gem.version     = SimpleCataloger::VERSION
  gem.platform    = Gem::Platform::RUBY
  gem.summary     = %Q{damn simple cataloger using directory convention}
  gem.description = <<-EOS
    damn simple catalog based on tagging file name.
    The tag are between bracket.
    For example the filename 'photo [sea][2010][summer]', associate
    with the name photo the tag sea,2010,summer.
  EOS
  gem.authors  = ["Tokiro"]
  gem.email    = "tokiro.oyama@gmail.com"
  gem.homepage = "http://github.com/tokiro/simple_cataloger"

  #
  # dependencies
  #

  #
  # bin
  #
  # s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.executables = %w{ scat }

  gem.extra_rdoc_files = [
      "LICENSE",
      "README.md"
  ]

  #
  # files
  #
  # s.files         = `git ls-files`.split("\n")
  gem.files = %w{LICENSE README.md Rakefile simple_cataloger.gemspec}
  gem.files.concat Dir['lib/**/*.rb']
  gem.files.concat Dir['web/**/*']
  gem.files.concat Dir['tasks/**/*.rake']

  #
  # test files
  #
  # s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.test_files = Dir['spec/**/*.rb']
  gem.test_files.concat Dir['spec/fixtures/**/*']


  # gem.require_paths = ["lib"]
end
