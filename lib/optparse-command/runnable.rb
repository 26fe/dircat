module OptParseCommand

  module Runnable

    def self.included(base) # :nodoc:
      base.extend ClassMethods
    end

    module ClassMethods
      #
      # run command
      #
      def run(argv = ARGV)
        cli_main = self.new
        cli_main.parse_and_execute(OpenStruct.new, argv)
      end

      #
      # force exit with the value of run
      #
      def run!
        exit run
      end
    end
  end

end #module


