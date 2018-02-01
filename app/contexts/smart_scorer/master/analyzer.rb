module SmartScorer
  module Master
    class Analyzer < Base::Analyzer
      def initialize(args)
        @transactions = args[:transactions]
        @accounts = args[:accounts]
      end

      def analyze!
        run_analyzers!
      end

      private

      def run_analyzers!
        results = {}
        analyzers.each do |analyzer|
          if analyzer[:should_run]
            klass = "SmartScorer::#{analyzer[:klass_string]}::Analyzer".constantize
            result = klass.new(analyzer[:args]).analyze!

            result_key = analyzer[:klass_string].downcase.parameterize.underscore.to_sym
            results[result_key] = result
          end
        end
        results
        # income_to_expenses_ratio = results[:incomes][:totals].sum/results[:expenses][:totals].sum.abs
      end

      def analyzers
        @analyzers ||= [
          {
            should_run: @transactions.try(:any?),
            klass_string: 'Expenses',
            args: { transactions: @transactions || [] }
          },
          {
            should_run: @transactions.try(:any?),
            klass_string: 'Incomes',
            args: { transactions: @transactions || [] }
          },
          {
            should_run: @accounts.try(:any?),
            klass_string: 'Accounts',
            args: { accounts: @accounts || [] }
          }
        ].freeze
      end
    end
  end
end