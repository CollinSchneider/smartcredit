class AddTableSmartScore < ActiveRecord::Migration
  def change
    create_table :smart_scores do |t|
      # t.references :user
      t.string :plaid_account_identifier
      t.float :score
      t.datetime :last_updated_on
    end
  end
end
