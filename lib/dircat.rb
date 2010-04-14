module DirCat
  def self.version
    cwd = Pathname(__FILE__).dirname.expand_path.to_s
    yaml = YAML.load_file(cwd + '/../VERSION.yml')
    major = (yaml['major'] || yaml[:major]).to_i
    minor = (yaml['minor'] || yaml[:minor]).to_i
    patch = (yaml['patch'] || yaml[:patch]).to_i
    "#{major}.#{minor}.#{patch}"
  end
end

# stdlib
require 'fileutils'
require 'tmpdir'
require 'yaml'
require 'ostruct'

require 'dircat/extension_md5'
require 'dircat/extension_numeric'

require 'dircat/cat'
require 'dircat/entry'
require 'dircat/report'
require 'dircat/cli/dircat_build'
