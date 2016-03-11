class OpenStruct

  def p_options(s = nil)
    puts s if s
    ary = singleton_methods.sort
    keys=[]
    ary.each { |i| keys.push(i) unless i.to_s.include?('=') }
    keys.each do |key|
      puts "\t#{key}: #{send key}"
    end
  end

end
