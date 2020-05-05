class CreateInvestorsTable < ActiveRecord::Migration[5.0]
    def change
        create_table  :investors do |t|
            t.string :first_name
            t.string  :last_name
            t.string  :username
            t.string  :password
            t.integer :broker_id
        end
    end
end
