module DirCat

  class Config

    # user config dir normally is
    #    ~/.dircat
    def self.user_config_dir
      # find directory where to store catalog data
      # depends on OS
      user_home_dir = ENV['HOME'] || ENV['APPDATA']
      if user_home_dir
        if RUBY_PLATFORM =~ /linux/
          config_dir = File.expand_path(File.join(user_home_dir, ".futils"))
        else
          config_dir = File.expand_path(File.join(user_home_dir, "futils"))
        end
        Dir.mkdir(config_dir) unless File.directory?(config_dir)
        config_dir
      else
        File.join(home_dir, "config")
      end
    end

  end
end  # end module DirCat
