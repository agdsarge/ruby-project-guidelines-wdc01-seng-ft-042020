class AddBankAccountColumnToInvestors < ActiveRecord::Migration[5.0]
  def change
      add_column :investors, :account_cash, :float
  end
end
