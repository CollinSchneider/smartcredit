Rails.application.routes.draw do

  get '/' => 'welcome#index'

  namespace :plaid do
    post '/get_access_token' => 'link#get_access_token'
  end
end
