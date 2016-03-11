module OptParseCommand

  def self.define_main(command_name, description = nil, &block)

#    unless block_given?
#      raise "define_main: missing block"
#    end

    cls = Class.new(CliMain) #do
#      def initialize(common_args)
#        @common_args = common_args
#      end
#
#      def opt_parser(options)
#        opt_parser       = OptionParser.new
#        opt_parser.banner= "#{self.class.description}"
#        opt_parser.on("-h", "--help", "show this message") do
#          puts opt_parser
#          options.exit = true
#        end
#      end
#
#      define_method("parse_and_run") do |argv|
#        options = OpenStruct.new
#        option_parser(options).parse(argv)
#        return false if options.exit
#        block.call(@common_args)
#      end
#    end

    s   = class << cls;
      self;
    end

    s.class_eval do
      define_method('command') { command_name }
      define_method("version") { "0.0.0" }
      define_method("description") { description ? description : "" }
    end
    cls
  end

end
