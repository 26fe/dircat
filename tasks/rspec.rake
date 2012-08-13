# -*- coding: utf-8 -*-
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)

  RSpec::Core::RakeTask.new do |t|
    t.rspec_opts = ["--color", "--format", "spec", '--backtrace']
    t.pattern    = 'spec/**/*_spec.rb'
  end
rescue LoadError
  puts "rspec (or a dependency) not available. Install it with: sudo gem install jeweler"
end
