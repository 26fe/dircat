# -*- coding: utf-8 -*-
module DirCat
  class CommandDiff < OptParseCommand::Command

    CliDirCat.register_command(self)

    def self.command
      "diff"
    end

    def self.description
      "Show diff from two catalogs"
    end

    def self.usage
      <<-EOS
Usage: dircat diff [options] <filedircat1> <filedircat2>
diff first catalog from second (<filedircat1> - <filedircat2>)
and then print the difference with the format specified on output
      EOS
    end

    def option_parser(options)
      parser = super(options)
      parser.on('-f FORMAT', '--fmt FORMAT', 'format (simple, ruby)') do |v|
        options.format = v
      end
      parser
    end

    def exec(main, options, rest)
      if rest.length < 2
        puts 'you must provide two args (catalogs or directory)'
        puts '-h to print help'
        return false
      end

      cat_filename1 = rest[0]
      cat_filename2 = rest[1]

      #
      # process first argument
      #
      if File.directory?(cat_filename1)
        puts "build first set from directory #{cat_filename1}"
        s1 = CatOnYaml.from_dir(cat_filename1)
      elsif File.exists?(cat_filename1)
        puts "load catalog #{cat_filename1}"
        s1 = CatOnYaml.from_file(cat_filename1)
      else
        puts "#{cat_filename1} is not a catalog file or directory"
        return 1
      end

      #
      # process second argument
      #
      if File.directory?(cat_filename2)
        puts "build first set from directory #{cat_filename2}"
        s2 = CatOnYaml.from_dir(cat_filename2)
      elsif File.exists?(cat_filename2)
        puts "load catalog #{cat_filename2}"
        s2 = CatOnYaml.from_file(cat_filename2)
      else
        puts "#{cat_filename2} is not a catalog file or directory"
        return 1
      end

      s3 = s1 - s2

      if s3.empty?
        puts "no difference (first catalog contains all file of second catalog)"
      else
        puts "differences (file in first catalog not contained in the second catalog)"
        case options.format
          when "simple"
            s3.fmt_simple
          when "ruby"
            s3.fmt_ruby(".")
          else
            s3.fmt_simple
        end
      end
      true
    end

  end
end
