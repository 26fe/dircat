# -*- coding: utf-8 -*-
begin
  require 'yard'
  YARD::Rake::YardocTask.new do |t|
    t.files   = ['lib/**/*.rb']
    t.options = [
        '--readme', 'README.md',
        '--any',
        '--extra',
        '--opts'
    ]
  end
rescue LoadError
  puts "Yard (or a dependency) not available. Install it with: sudo gem install jeweler"
end
