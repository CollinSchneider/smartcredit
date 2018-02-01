module SmartScorer
  module Calculator
    class Recurring < Base::Calculator
      # include InstanceVariableHelper

      def initialize(args)
        # set_instance_variables(args)
        @dates = format_dates(args[:dates])
        @difference_array = []
        @scores_array = []
      end

      # returns a float (standard deviation), 0 being absolutely recurring
      def calculate!
        create_difference_array
        calc_standard_deviation
      end

      private

      def format_dates(dates_array)
        dates_array.sort!.collect{ |date| date.to_date }
      end

      def create_difference_array
        return @difference_array = [] if @dates.count < 3
        @dates.each_with_index do |date, index|
          next_date = @dates[index+1]
          break unless next_date
          diff_in_days = (next_date - date).to_i
          @difference_array << diff_in_days
        end
        # because dates are sorted on initialize, we can trust difference_array to also be in order
        @difference_array
      end

      def calc_standard_deviation
        return nil unless @difference_array.any?
        differences = @difference_array.collect(&:to_f)
        dif_mean = differences.sum/differences.count
        differences.collect! { |num| (num-dif_mean)**2 }
        std_mean = differences.sum/differences.count
        Math.sqrt(std_mean)
      end
    end
  end
end

# example difference_array = [7.000000001273148, 6.000000002430556]
# 7 = difference in days between transaction index 0 and index 1
# 6 = difference in days between transaction index 1 and index 2