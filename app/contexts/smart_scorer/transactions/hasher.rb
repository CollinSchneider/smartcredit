module SmartScorer
  module Transactions
    class Hasher < Base::Hasher

      def initialize(transactions, transaction_check_method = nil, options = {})
        @transactions = transactions
        # determines what transactions we want to evaluate
        # current choices are is_expense? or is_income?
        # if nil, it will use all transactions
        @transaction_check_method = transaction_check_method
        @hash = { totals: [], by_name: {}, by_date: {} }
      end

      def create_hash!
        # upon optimization, we should not iterate through every transaction, but rather
        # start from maybe one week earlier from today
        @transactions.each { |transaction| write_transaction_to_hash(transaction) }
        @hash
      end

      private

      # purchases = +, incomes = - wait nvm idk
      def write_transaction_to_hash(transaction)
        return unless @transaction_check_method.nil? || send(@transaction_check_method, transaction)
        name = transaction['name']
        tally_total(transaction)
        if transaction_name_previously_recorded?(name)
          update_transaction_name_node(transaction)
          calculate_recurring_score(name)
        else
          create_transaction_name_node(transaction)
        end
        # date = transaction['date']
        # if transaction_date_previously_recorded?(date)
        #   update_transaction_date_node(transaction)
        # else
        #   create_transaction_date_node(transaction)
        # end
      end

      # move to module
      def is_expense?(transaction)
        transaction['amount'] < 0
      end

      # move to module
      def is_income?(transaction)
        transaction['amount'] > 0
      end

      def transaction_name_previously_recorded?(transaction_name)
        @hash[:by_name][transaction_name].present?
      end

      def tally_total(transaction)
        @hash[:totals] << transaction['amount']
      end

      def update_transaction_name_node(transaction)
        amount = transaction['amount']
        date = transaction['date'] # we should probably parse this down to days
        name = transaction['name']
        @hash[:by_name][name][:amounts] << amount
        if @hash[:by_name][name][:dates][date].present?
          @hash[:by_name][name][:dates][date] << amount
        else
          @hash[:by_name][name][:dates][date] = [amount]
        end
      end

      def create_transaction_name_node(transaction)
        amount = transaction['amount']
        date = transaction['date']
        name = transaction['name']
        hash = {
          amounts: [amount],
          recurring_score: nil,
          dates: {}
        }
        hash[:dates][date] = [amount]
        @hash[:by_name][name] = hash
      end

      def calculate_recurring_score(transaction_name)
        transactions_dates = @hash[:by_name][transaction_name][:dates].keys
        recurring_score = if transactions_dates.count < 3
                            nil
                          else
                            SmartScorer::Calculators::Recurring.new(dates: transactions_dates).calculate!
                          end
        @hash[:by_name][transaction_name][:recurring_score] = recurring_score
      end
    end
  end
end