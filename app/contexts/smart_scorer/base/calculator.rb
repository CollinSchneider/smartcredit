module SmartScorer
  module Base
    class Calculator
      def initialize(args)
        super(args)
      end

      def calculate!
        raise 'Parent class must implement.'
      end
    end
  end
end