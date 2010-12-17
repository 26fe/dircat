# -*- coding: utf-8 -*-
#
# spec
#
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)

  RSpec::Core::RakeTask.new do |t|
    t.rspec_opts = ["--color", "--format", "spec", '--backtrace']
    t.pattern    = 'spec/**/*_spec.rb'
  end

#desc "Generate HTML report for failing examples"
#RSpec::Core::RakeTask.new('failing_examples_with_html') do |spec|
#  spec.pattern = 'failing_examples/**/*.rb'
#  spec.rspec_opts = ["--format", "html:doc/reports/tools/failing_examples.html", "--diff"]
#  spec.fail_on_error = false
#end
rescue LoadError
  puts "rspec (or a dependency) not available. Install it with: sudo gem install jeweler"
end


#
#
#begin
#  require 'rcov/rcovtask'
#  Rcov::RcovTask.new do |test|
#    test.libs << 'test'
#    test.pattern = 'test/**/*_test.rb'
#    test.verbose = true
#  end
#rescue LoadError
#  task :rcov do
#    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
#  end
#end
#
#
##
## spec
##
#
#require 'spec/rake/spectask'
#
#desc "Run all examples"
#Spec::Rake::SpecTask.new('spec') do |t|
#  t.spec_files = FileList['spec/**/*_spec.rb']
#end
#
#desc "Generate HTML report for failing examples"
#Spec::Rake::SpecTask.new('failing_examples_with_html') do |t|
#  t.spec_files = FileList['failing_examples/**/*.rb']
#  t.spec_opts = ["--format", "html:doc/reports/tools/failing_examples.html", "--diff"]
#  t.fail_on_error = false
#end
#
