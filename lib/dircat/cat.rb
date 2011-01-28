# -*- coding: utf-8 -*-
module DirCat

  class Cat

    #
    # Directory name
    #
    attr_reader :dirname

    #
    # creation date
    #
    attr_accessor :ctime


    attr_reader :verbose_level

    def initialize(options = {})
      @verbose_level  = options.delete(:verbose) || 0
      @dirname        = ""
      @ctime          = DateTime.now
      @entries        = Array.new
      @md5_to_entries = Hash.new
    end

    def self.from_dir(dirname, options = {})
      new(options).from_dir(dirname)
    end

    def self.from_file(filename, options = {})
      new(options).from_file(filename)
    end

    def self.load(file_or_dir, options = {})
      new(options).load(file_or_dir)
    end

    def from_dir(dirname)
      if not File.directory?(dirname)
        raise "'#{dirname}' is not a directory or doesn't exists"
      end
      @dirname = File.expand_path dirname
      @ctime   = DateTime.now
      _load_from_dir
      self
    end

    def from_file(filename)
      if not File.exist?(filename)
        raise DirCatException.new, "'#{filename}' not exists"
      end
      dircat_ser = YAML::load(File.open(filename))
      @dirname   = dircat_ser.dirname
      @ctime     = dircat_ser.ctime
      dircat_ser.entries.each { |entry_ser|
        add_entry(Entry.new.from_ser(entry_ser))
      }
      self
    end

    def load(file_or_dir)
      if File.directory?(file_or_dir)
        from_dir(file_or_dir)
      elsif File.exists?(file_or_dir)
        from_file(file_or_dir)
      else
        raise DirCatException.new, "'#{file_or_dir}' not exists"
      end
    end

    def to_ser
      dircat_ser         = DirCatSer.new
      dircat_ser.version = 0.1
      dircat_ser.dirname = @dirname
      dircat_ser.ctime   = @ctime
      dircat_ser.entries = []
      @entries.each { |entry|
        dircat_ser.entries << entry.to_ser
      }
      dircat_ser
    end

#    def _load_from_dir
#      old_dirname = Dir.pwd
#      Dir.chdir(@dirname)
#      Dir["**/*"].each { |f|
#        next if File.directory?(f)
#
#        if @verbose_level > 0
#          cr    = "\r"
#          clear = "\e[K"
#          print "#{cr}#{filename}#{clear}"
#        end
#
#        add_entry(Entry.new.from_filename(f))
#      }
#      if @verbose_level > 0
#        print "\n"
#      end
#      Dir.chdir(old_dirname)
#      self
#    end

    CR    = "\r"
    CLEAR = "\e[K"

    def _load_from_dir
      me = self
      TreeVisitor::DirTreeWalker.new.run @dirname  do
        on_leaf do |filename|
          me.add_entry(Entry.new.from_filename(filename))
          if me.verbose_level > 0
            print "#{CR}#{filename}#{CLEAR}"
          end
        end
      end
      self
    end

    def save_to(file)
      if file.kind_of?(String)
        begin
          File.open(file, "w") do |f|
            f.puts to_ser.to_yaml
          end
        rescue Errno::ENOENT
          raise DirCatException.new, "DirCat: cannot write into '#{file}'", caller
        end
      else
        file.puts to_ser.to_yaml
      end
    end

    def size
      @entries.size
    end

    def empty?
      @entries.size == 0
    end

    def bytes
      @entries.inject(0) { |sum, entry| sum + entry.size }
    end

    def report
      dups = duplicates
      s    = "Base dir: #{@dirname}\n"
      s    += "Nr. file: #{size}"
      if duplicates.size > 0
        s+= " (duplicates #{dups.size})"
      end
      s += "\nBytes: #{bytes.with_separator}"
      s
    end

    def add_entry(e)
      @entries.push(e)
      if @md5_to_entries.has_key?(e.md5)
        @md5_to_entries[e.md5].push(e)
      else
        @md5_to_entries[e.md5] = [e]
      end
    end

    def contains(e)
      @md5_to_entries.has_key?(e.md5)
    end

    def -(s)
      result = Cat.new
      @entries.each { |e|
        result.add_entry(e) unless s.contains(e)
      }
      result
    end

    def duplicates
      list = []
      @md5_to_entries.each_value do |ee|
        next if ee.size < 2
        list.push(ee)
      end
      list
    end

    def fmt_simple
      @entries.each { |e|
        print e.to_s
      }
    end

    def fmt_report
      DirCat::report(@entries, :md5, :name, :path)
    end

    def fmt_ruby(dst)
      puts "require 'fileutils'"
      @entries.each { |entry|
        src = File.join(@dirname, entry.path, entry.name);
        puts "FileUtils.cp( \"#{src}\", \"#{dst}\" )"
      }
    end

    def list_dup
      r = ""
      duplicates.flatten.each { |e|
        r += e.to_s + "\n"
      }
      r
    end

    def script_dup
      r = "require 'fileutils'\n"
      duplicates.each { |entries|
        flg_first = true
        r         += "\n"
        entries.each { |entry|
          src = File.join(@dirname, entry.path, entry.name);
          if flg_first
            flg_first = false
            r         += "# FileUtils.mv( \"#{src}\", \"#{Dir.tmpdir}\" )\n"
          else
            r += "FileUtils.mv( \"#{src}\", \"#{Dir.tmpdir}\" )\n"
          end
        }
      }
      r
    end

  end
end
