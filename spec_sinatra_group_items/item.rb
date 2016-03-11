class Item

  attr_reader :day
  attr_reader :title

  def initialize(title,day)
    @title = title
    @day = Date.parse(day)
  end

  def reverse_title
    @title.reverse
  end

  def to_s
    @title
  end
end
