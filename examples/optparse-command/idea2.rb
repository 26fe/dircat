module YourModule

  def self.included(base) # :nodoc:
    base.extend ClassMethods
  end

  module ClassMethods
    # Define class methods here.
    def some_class_method
      puts "In some_class_method"
    end
  end

  def some_instance_method
    puts "some_instance_method"
  end

end

class YourClass
  include YourModule
end

YourClass.some_class_method

y = YourClass.new
y.some_instance_method
