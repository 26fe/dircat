require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sinatra::GroupItems do
  context 'alphabetic' do
    it 'should group_items_by_letters by 1 item' do
      items = [Item.new('ab', '2010-07-10'), Item.new("ba", "2010-08-10")]
      r     = group_items(items, :group_size => 1)
      # pp r
      expect(r).to have(2).items
      expect(r[0][0]).to be == ["A"]
      expect(r[0][1].first.title).to be == "ab"
    end

    it 'should group_items_by_letters by 2 item' do
      items = [Item.new("ab", '2010-07-10'), Item.new("ba", "2010-08-10")]
      r     = group_items(items, :group_size => 2)
      # pp r
      expect(r).to have(1).items
      expect(r[0][0]).to be == ["A", "B"]
      expect(r[0][1][1].title).to be == "ba"
    end

    it 'should group_items_by_letters using block' do
      items = [Item.new("ab", "2010-07-10"), Item.new("ba", "2010-08-10")]
      r     = group_items(items, :group_size => 1, :header => proc { |i| i.reverse_title })
      # pp r
      expect(r).to have(2).items
    end
  end

  context 'time' do
    it 'should group_items_by_letters by time' do
      items = [Item.new("ab", "2010-07-10"), Item.new("ba", "2010-08-10")]
      r     = group_items(items, :group_size => 1, :header => proc { |i| i.day })
      expect(r).to have(2).items
      expect(r[0][0]).to be == [Date.parse("2010-07-10")]
      expect(r[1][0]).to be == [Date.parse("2010-08-10")]
      expect(r[0][1].first.title).to be == "ab"
    end
  end

end
