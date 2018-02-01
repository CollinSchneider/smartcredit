class WelcomeController < ApplicationController
  # TRANSACTIONS = [{ 'name' => 'Uber', 'date' => Time.current, 'amount' => -100.0 }, { 'name' => 'Mack Weldon', 'date' => Time.current, 'amount' => 2_200.0 }, { 'name' => 'Chipotle', 'date' => Time.current, 'amount' => -300.0 }, { 'name' => 'Mack Weldon', 'date' => 14.days.from_now, 'amount' => 2_200.0 }, { 'name' => 'Mack Weldon', 'date' => 28.days.from_now, 'amount' => 2_200.0 }, { 'name' => 'Mack Weldon', 'date' => 41.days.from_now, 'amount' => 2_200.0 }]
  TRANSACTIONS = [
    { 'name' => 'Uber', 'date' => Time.current, 'amount' => -100.0 },
    { 'name' => 'Mack Weldon', 'date' => Time.current, 'amount' => 2_200.0 },
    { 'name' => 'Chipotle', 'date' => Time.current, 'amount' => -300.0 },
    { 'name' => 'Mack Weldon', 'date' => 14.days.from_now, 'amount' => 2_200.0 },
    { 'name' => 'Mack Weldon', 'date' => 28.days.from_now, 'amount' => 2_200.0 },
    { 'name' => 'Mack Weldon', 'date' => 41.days.from_now, 'amount' => 2_200.0 }
  ]

  def index
    byebug
    scorer = SmartScorer::Master::Analyzer.new(transactions: TRANSACTIONS)
  end

end