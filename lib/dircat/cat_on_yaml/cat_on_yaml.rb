# -*- coding: utf-8 -*-
module DirCat

  #
  # Catalog of files (contained into directory :-))
  #
  class CatOnYaml

    #
    # Directory name
    #
    attr_reader :dirname

    #
    # creation date
    #
    attr_accessor :ctime

    #
    # verbose level used to print message on $stdout
    #
    attr_reader :verbose_level
    attr_reader :show_progress

    # @param [Hash] options
    #   @option options [Number] :verbose list of ignore pattern
    def initialize(options = {})
      @verbose_level = options.delete(:verbose) || 0
      @show_progress = options.delete(:show_progress)
      @dirname = ""
      @ctime = DateTime.now
      @entries = Array.new
      @md5_to_entries = Hash.new
    end

    #
    # Build catalog from a directory
    # @param [String] dirname directory path
    # @param options (see #initialize)
    #
    def self.from_dir(dirname, options = {})
      new(options).from_dir(dirname)
    end

    #
    # Load catalog from a serialize file
    # @param [String] filename
    # @param options (see #initialize)
    #
    def self.from_file(filename, options = {})
      new(options).from_file(filename)
    end

    def self.load(file_or_dir, options = {})
      new(options).load(file_or_dir)
    end

    # Build a catalog from a directory
    def from_dir(dirname)
      unless File.directory?(dirname)
        raise "'#{dirname}' is not a directory or doesn't exists"
      end
      @dirname = File.expand_path dirname
      @ctime = DateTime.now
      _load_from_dir
      self
    end

    # Load catalog from a file
    def from_file(filename)
      unless File.exist?(filename)
        raise DirCatException.new, "'#{filename}' not exists"
      end
      dircat_ser = File.open(filename) { |f| YAML::load(f) }
      @dirname = dircat_ser.dirname
      @ctime = dircat_ser.ctime
      dircat_ser.entries.each do |entry_ser|
        add_entry(Entry.from_ser(entry_ser))
      end
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

    # serialize catalog
    # @return [DirCatSer] serialized catalog
    def to_ser
      dircat_ser = DirCatSer.new
      dircat_ser.dircat_version = DirCat::VERSION
      dircat_ser.dirname = @dirname
      dircat_ser.ctime = @ctime
      dircat_ser.entries = []
      @entries.each do |entry|
        dircat_ser.entries << entry.to_ser
      end
      dircat_ser
    end

    CR = "\r"
    CLEAR = "\e[K"

    #
    # @private
    #
    def _load_from_dir
      start = Time.now
      me = self
      bytes = 0
      TreeRb::DirTreeWalker.new.run @dirname do
        on_leaf do |filename|
          entry = Entry.from_filename(filename)
          me.add_entry(entry)
          bytes += entry.size
          if me.verbose_level > 0
            print "#{CR}#{filename}#{CLEAR}"
          end
          if me.show_progress
            sec = Time.now - start
            print "#{CR}bytes: #{bytes.to_human} time: #{sec} bytes/sec #{bytes/sec} #{CLEAR}"
          end
        end
      end
      self
    end

    #
    # Save serialized catalog to file
    # @param [String,File] file
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

    #
    # number of entries (files)
    # @return [Number]
    def size
      @entries.size
    end

    #
    # number of entries == 0
    #
    def empty?
      @entries.size == 0
    end

    #
    # total size number of file cataloged
    # @return [Number]
    def bytes
      @entries.inject(0) { |sum, entry| sum + entry.size }
    end

    #
    # simple report with essential information about this catalog
    # @return [String] report
    def report
      dups = duplicates
      s = "Base dir: #{@dirname}\n"
      s += "Nr. file: #{size}"
      if dups.size > 0
        s+= " (duplicates #{dups.size})"
      end
      s += "\nBytes: #{bytes.with_separator}"
      s
    end

    #
    # add entry to this catalog
    # @private
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

    #
    # return differences from this catalog and right catalog
    # param [Cat] right
    # @return [CatOnYaml]
    def -(right)
      result = CatOnYaml.new
      @entries.each do |e|
        result.add_entry(e) unless right.contains(e)
      end
      result
    end

    #
    # list of entries on stdout
    # @return[String]
    def fmt_simple
      @entries.inject('') { |s, e| s << e.to_s << "\n" }
    end

    alias :to_s :fmt_simple

    #
    # print a complex report on stdout
    #
    def fmt_report(*columns)
      columns = [:md5, :name, :path, :size] unless columns
      OptParseCommand::report(@entries, *columns)
    end

    def fmt_ruby(dst)
      puts "require 'fileutils'"
      @entries.each { |entry|
        src = File.join(@dirname, entry.path, entry.name);
        puts "FileUtils.cp( \"#{src}\", \"#{dst}\" )"
      }
    end

    #
    # @return [Array] entries representing duplicate files
    #
    def duplicates
      list = []
      @md5_to_entries.each_value do |ee|
        next if ee.size < 2
        list.push(ee)
      end
      list
    end

    def list_dup
      r = ""
      duplicates.flatten.each do |e|
        r += e.to_s + "\n"
      end
      r
    end

    #
    # return ruby script to eliminate duplicated
    # @return [String] ruby script
    #
    def script_dup
      r = "require 'fileutils'\n"
      duplicates.each do |entries|
        flg_first = true
        r += "\n"
        entries.each do |entry|
          src = File.join(@dirname, entry.path, entry.name)
          if flg_first
            flg_first = false
            r += "# FileUtils.mv( \"#{src}\", \"#{Dir.tmpdir}\" )\n"
          else
            r += "FileUtils.mv( \"#{src}\", \"#{Dir.tmpdir}\" )\n"
          end
        end
      end
      r
    end

  end
end
