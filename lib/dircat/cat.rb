module DirCat
  #
  # GLOBAL VAR
  #

  $VERBOSE_LEVEL = 0

  class Cat

    attr_reader :dirname
    # data di creazione
    attr_reader :ctime
    attr_writer :ctime
    # attr_reader :entries

    def from_dirname( dirname )
      # puts "#{self.class.name}#initialize"
      @dirname = dirname
      @ctime = DateTime.now
      @entries = Array.new
      @md5ToEntries = Hash.new
      self
    end

    def from_ser( dircat_ser )
      @dirname = dircat_ser.dirname
      @ctime   = dircat_ser.ctime
      @entries = Array.new
      @md5ToEntries = Hash.new
      dircat_ser.entries.each{ |entry_ser|
        add_entry( Entry.new.from_ser( entry_ser ) )
      }
      self
    end

    def to_ser
      dircat_ser = DirCatSer.new
      dircat_ser.version = 0.1
      dircat_ser.dirname = @dirname
      dircat_ser.ctime   = @ctime
      dircat_ser.entries = []
      @entries.each { |entry|
        dircat_ser.entries << entry.to_ser
      }
      dircat_ser
    end

    def self.loadfromdir( dirname )
      # puts "#{self.class.name}#loadfromdir( #{dirname} )"
      if not File.directory?( dirname )
        raise "'#{dirname}' non e' una directory o non esiste"
      end

      s = self.new
      s.from_dirname( File.expand_path( dirname ) )
      s._loadfromdir
    end

    def _loadfromdir()
      old_dirname = Dir.pwd
      Dir.chdir( @dirname )
      Dir["**/*"].each { |f|
        # puts "#{self.class.name}#loadfromdir #{f}"
        next if File.directory?( f )
        add_entry( Entry.new.from_filename( f ) )
      }
      if $VERBOSE_LEVEL > 0
        print "\n"
      end
      Dir.chdir( old_dirname )
      self
    end

    def self.loadfromfile( filename )
      if not File.exist?( filename )
        raise DirCatException.new, "'#{filename}' not exists"
      end
      dircat_ser = YAML::load( File.open( filename ) )
      Cat.new.from_ser( dircat_ser )
    end

    def savetofile( file )
      if file.kind_of?(String)
        begin
          File.open( file, "w" ) do |f|
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

    def bytes
      @entries.inject(0) {|sum, entry| sum + entry.size }
    end

    def report
      dups = duplicates
      s = "Directory base: #@dirname\n" +
        "Nr. file #{size}\n" +
        "Bytes #{bytes.with_separator}"
      if duplicates.size > 0
        s+= "\n duplicates #{dups.size}"
      end
      s
    end

    def add_entry( e )
      @entries.push( e )
      if @md5ToEntries.has_key?( e.md5 )
        # puts "Entry duplicata!!!"
        @md5ToEntries[ e.md5 ].push( e )
      else
        @md5ToEntries[ e.md5 ] = [ e ]
      end
    end

    def contains( e )
      @md5ToEntries.has_key?( e.md5 )
    end

    def -(s)
      result = Cat.new.from_dirname( @dirname )
      @entries.each { |e|
        result.add_entry(e) unless s.contains(e)
      }
      result
    end

    def duplicates
      list = []
      @md5ToEntries.each_value do |ee|
        next if ee.size < 2
        list.push( ee )
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

    def fmt_ruby( dst )
      puts "require 'fileutils'"
      @entries.each { |entry|
        src = File.join( @dirname, entry.path, entry.name );
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
        r += "\n"
        entries.each{ |entry|
          src = File.join( @dirname, entry.path, entry.name );
          if flg_first
            flg_first = false
            r += "# FileUtils.mv( \"#{src}\", \"#{Dir.tmpdir}\" )\n"
          else
            r += "FileUtils.mv( \"#{src}\", \"#{Dir.tmpdir}\" )\n"
          end
        }
      }
      r
    end

  end
end
