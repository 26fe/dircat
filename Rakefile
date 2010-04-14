require 'rubygems'
require 'rake'
require 'yaml'

task :test => :check_dependencies
task :default => :spec

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    gem.name = "dircat"
    gem.summary = "command line utilites to manage catalogs of directory"
    gem.description = %Q{
      command line utilites to manage catalogs of directory
    }
    gem.authors = ["Giovanni Ferro"]
    gem.email = "giovanni.ferro@gmail.com"
    gem.homepage = "http://github.com/gf/dircat"

    #
    # dependecies
    #
    # gem.add_dependency('treevisitor')
    gem.add_development_dependency "rspec"

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
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

#
# rdoc
#
require 'rake/rdoctask'
require 'sdoc'
Rake::RDocTask.new do |rdoc|
  config = YAML.load(File.read('VERSION.yml'))
  version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"

  rdoc.rdoc_dir = 'doc'
  rdoc.title = "dircat #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')

  # sdoc
  rdoc.options << '--fmt' << 'shtml' # explictly set shtml generator
  rdoc.template = 'direct' # lighter template used on railsapi.com

end

#
# spec
#

require 'spec/rake/spectask'

desc "Run all examples"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end

desc "Generate HTML report for failing examples"
Spec::Rake::SpecTask.new('failing_examples_with_html') do |t|
  t.spec_files = FileList['failing_examples/**/*.rb']
  t.spec_opts = ["--format", "html:doc/reports/tools/failing_examples.html", "--diff"]
  t.fail_on_error = false
end

#
# rubyforge
#
#begin
#  require 'rake/contrib/sshpublisher'
#  namespace :rubyforge do
#    desc "Release gem and RDoc documentation to RubyForge"
#    task :release => ["rubyforge:release:gem", "rubyforge:release:docs"]
#
#    namespace :release do
#      desc "Publish RDoc to RubyForge."
#      task :docs => [:rdoc] do
#        config = YAML.load(
#            File.read(File.expand_path('~/.rubyforge/user-config.yml'))
#        )
#
#        host = "#{config['username']}@rubyforge.org"
#        remote_dir = "/var/www/gforge-projects/dircat"
#        local_dir = 'rdoc'
#
#        Rake::SshDirPublisher.new(host, remote_dir, local_dir).upload
#      end
#    end
#  end
#rescue LoadError
#  puts "Rake SshDirPublisher is unavailable or your rubyforge environment is not configured."
#end
