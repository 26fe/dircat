# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dircat}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tokiro"]
  s.date = %q{2009-05-23}
  s.email = %q{tokiro.oyama@gmail.com}
  s.executables = ["dircat-cfr.rb", "dircat-query.rb", "dircat-cmp.rb", "dircat-build.rb"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "lib/dircat.rb",
     "lib/dircat/cli/dircat_build.rb",
     "lib/dircat/cli/dircat_cfr.rb",
     "lib/dircat/cli/dircat_cmp.rb",
     "lib/dircat/cli/dircat_query.rb",
     "lib/dircat/dircat.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/tokiro/dircat}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{ralbum}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}
  s.test_files = [
    "test/dircat/tc_dircat.rb",
     "test/dircat/tc_dircat_build.rb",
     "test/test_dircat.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<tree_visitor>, [">= 0"])
    else
      s.add_dependency(%q<tree_visitor>, [">= 0"])
    end
  else
    s.add_dependency(%q<tree_visitor>, [">= 0"])
  end
end
