module SmartScorer
  module Base
    class Hasher
      def initializer(args)
        super(args)
      end

      def create_hash!
        raise 'Parent class must implement.'
      end
    end
  end
end