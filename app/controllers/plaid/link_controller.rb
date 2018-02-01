class Plaid::LinkController < ApplicationController
  skip_before_filter :verify_authenticity_token

  CLIENT_ID=
  PUBLIC_KEY=
  SECRET_KEY=
  URL='https://sandbox.plaid.com'

  def get_access_token
    public_token = params['public_token']
    plaid = Plaid::Composer.new(public_token, mock: true)
    analyze_hash = {
      accounts: plaid.accounts,
      transactions: plaid.transactions
    }
    SmartScorer::MasterAnalyzer.new(analyze_hash).analyze!

    render json: {
      transactions: transactions,
      accounts: accounts
    }
  end

end