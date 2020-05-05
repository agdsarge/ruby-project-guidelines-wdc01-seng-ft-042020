class CreateCompanyTable < ActiveRecord::Migration[5.0]
    def change
        create_table  :companies do |t|
            t.string  :ticker
            t.string  :name
            t.float  :current_price
        end
    end
end
