class CreateTransactionTable < ActiveRecord::Migration[5.0]
    def change
        create_table  :transactions do |t|
            t.integer  :investor_id
            t.integer  :company_id
            t.datetime  :transaction_date
            t.float   :price
            t.integer :quantity
            t.boolean :is_purchase?
        end
    end
end
