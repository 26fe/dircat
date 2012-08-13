# -*- coding: utf-8 -*-
module DirCat

  class EntrySer < OpenStruct
  end

  #
  # Entry
  #
  class Entry

    attr_reader :md5
    attr_reader :name
    attr_reader :path
    attr_reader :size
    attr_reader :mtime

    def from_filename( filename )
      @name = File.basename(filename)
      @path = File.dirname(filename)
      stat = File.lstat(filename)
      @size = stat.size
      @mtime = stat.mtime
      # self.md5 = Digest::MD5.hexdigest(File.read( f ))
      @md5 = MD5.file( filename ).hexdigest unless stat.symlink?
      self
    end

    def from_ser( entry_ser )
      @md5   = entry_ser.md5
      @name  = entry_ser.name
      @path  = entry_ser.path
      @size  = entry_ser.size
      @mtime = entry_ser.mtime
      self
    end

    def to_ser
      entry_ser = EntrySer.new
      entry_ser.md5   = @md5
      entry_ser.name  = @name
      entry_ser.path  = @path
      entry_ser.size  = @size
      entry_ser.mtime = @mtime
      entry_ser
    end

    def to_s
      @md5 + "  " + @name + "\t " + @path + "\n"
    end

  end

  class DirCatSer < OpenStruct
  end


  class DirCatException < RuntimeError
  end

end
