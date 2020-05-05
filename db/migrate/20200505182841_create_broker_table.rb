class CreateBrokerTable < ActiveRecord::Migration[5.0]
  def change
      create_table  :brokers do |t|
          t.string  :first_name
          t.string  :last_name
          t.string  :username
          t.string  :password
          t.string  :email
          t.string  :telephone
      end
  end
end
