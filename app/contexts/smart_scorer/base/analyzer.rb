module SmartScorer
  module Base
    class Analyzer
      def initializer(args)
        super(args)
      end

      def analyze!
        raise "Parent class must implement."
      end
    end
  end
end