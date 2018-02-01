module SmartScorer
  module Incomes
    class Analyzer < Base::Analyzer
      def initialize(args)
        @transactions = args[:transactions]
      end

      def analyze!
        SmartScorer::Transactions::Hasher.new(@transactions, :is_income?).create_hash!
      end
    end
  end
end