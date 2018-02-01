module SmartScorer
  module Expenses
    class Analyzer < Base::Analyzer
      def initialize(args)
        @transactions = args[:transactions]
      end

      def analyze!
        SmartScorer::Transactions::Hasher.new(@transactions, :is_expense?).create_hash!
      end
    end
  end
end