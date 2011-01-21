# -*- coding: utf-8 -*-
class Numeric
  #
  # returns a string separated by the thousands <separator>
  # es.: 100000 -> 1.000.000
  #
  def with_separator( separator = ',', length = 3 )
    splitter = Regexp.compile "(\\d{#{length}})"
    before, after = self.to_s.split('.')
    before = before.reverse.gsub splitter, '\1' + separator
    str = "#{ before.chomp( separator ).reverse }"
    str += ".#{ after }" if after
    str
  end
end
