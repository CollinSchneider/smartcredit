class Plaid::Composer
  attr_accessor :access_token # maybe not ...?
  CLIENT_ID='5a187d104e95b865a853bac5'
  PUBLIC_KEY='6640e7ebc8314478b5652fcdfb19ba'
  SECRET_KEY='73e772bfddb6810914c9c3f0435c66'
  URL='https://sandbox.plaid.com'

  def initialize(public_token, options = {})
    set_instance_variables(public_token, options)
  end

  def transactions
    transaction_response = @client.transactions.get(@access_token, @transactions_start_date, @transactions_end_date, count: @tranasactions_count, offset: @transactions_offset)
    # transaction_response['accounts']
    # transaction_response['total_transactions']
    transaction_response['transactions']
  end
  
  def accounts
    accounts_response = @client.accounts.get(@access_token)
    accounts_response['accounts']
  end

  private
  def set_instance_variables(public_token, options)
    @client ||= Plaid::Client.new(
      env: :sandbox,
      client_id: CLIENT_ID,
      secret: SECRET_KEY,
      public_key: PUBLIC_KEY
    )
    @public_token ||= public_token
    @access_token ||= get_access_token
    @transactions_start_date ||= options[:transactions_start_date] || '2016-01-01'
    @transactions_end_date ||= options[:transactions_end_date] || '2017-12-31'
    @transactions_count ||= options[:transactions_count] || 250
    @transactions_offset ||= options[:transactions_offset] || 0
  end

  def get_access_token
    @access_token ||= @client.item.public_token.exchange(@public_token)['access_token']
  end
end

  # # NO ACCESS :(
  # # identity_response = @client.identity.get(access_token)
  # #
  # # income_response = @client.income.get(access_token)
  #
  # accounts_response = @client.accounts.get(access_token)
  #
  # transaction_response = @client.transactions.get(access_token, '2016-01-01', '2017-01-01', count: 250, offset: 0)
  # # byebug
  #
  # render json: {
  #   transactions: transaction_response['transactions'],
  #   identity: {
  #     # identity_response
  #   },
  #   income: {
  #
  #   },
  #   accounts: accounts_response['accounts']
  # }
