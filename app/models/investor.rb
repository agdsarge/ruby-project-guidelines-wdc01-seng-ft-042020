class Investor < ActiveRecord::Base
    has_many :transactions
    has_many :companies, through: :transactions
    belongs_to :broker

    def get_broker_contact
        br_full_name = "#{self.broker.first_name} #{self.broker.last_name}"
        "Your friendly trader is #{br_full_name}.\nTheir phone number is #{self.broker.telephone}.\n Their email address is #{self.broker.email}."
    end

    def buy_stock(tckr, quantity)
        #check_funds
        execute_transaction(tckr, quantity, true)
    end

    def sell_stock(tckr, quantity)
        execute_transaction(tckr, quantity, false)
    end

    private
    def execute_transaction(tckr, quantity, is_purchase)

        company = Company.find_by(ticker: tckr.upcase)
        today = Time.now
        binding.pry
        x = Transaction.find_or_create_by(investor_id: self.id, company_id: company.id, transaction_date: today, price: company.current_price, quantity: quantity, is_purchase?: is_purchase)
        x.save
    end
end
