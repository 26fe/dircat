# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'optparse-command/version'

Gem::Specification.new do |gem|
  gem.name = 'optparse-command'
  gem.version = OptParseCommand::VERSION
  gem.platform = Gem::Platform::RUBY
  gem.summary = 'opt parse command'
  gem.description = <<-EOS
    optparse-command
  EOS
  gem.authors = ["Tokiro"]
  gem.email = "tokiro.oyama@gmail.com"
  gem.homepage = "http://github.com/tokiro/optparse-command"

  #
  # dependencies
  #
  gem.add_development_dependency(%q<rake>, [">= 0"])
  gem.add_development_dependency(%q<yard>, [">= 0"])
  gem.add_development_dependency(%q<rspec>, [">= 0"])

  #
  # bin
  #
  # s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  gem.extra_rdoc_files = %w(LICENSE README.md)
  #
  # files
  #
  # s.files         = `git ls-files`.split("\n")
  gem.files = %w{LICENSE README.md Rakefile optparse-command.gemspec .gemtest}
  gem.files.concat Dir['lib/**/*.rb']
  gem.files.concat Dir['tasks/**/*.rake']

  gem.files.concat Dir['examples/**/*.rb']
  gem.files.concat Dir['examples/example_2/bin/*']

  #
  # test files
  #
  gem.test_files = Dir['spec/**/*.rb']
  # s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ['lib']
end
