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

    def stock_position(tckr)

        co = Company.find_by(ticker: tckr.upcase)
        tr_arr = Transaction.where("investor_id = ? AND company_id = ?", self.id, co.id)
        output = {ticker: tckr, shares: 0, total_value: 0.0 }

        tr_arr.each do |trans|
            puts trans
            if trans.is_purchase?
                output[:shares] += trans.quantity
                output[:total_value] += trans.quantity * trans.price
            else
                output[:shares] -= trans.quantity
                output[:total_value] -= trans.quantity * trans.price
            end

        end
        output
    end

    def all_positions
        # call stock_positions
        tr_arr = Transaction.where("investor_id = ?", self.id)
    
        return_arr = tr_arr.map do |trans|
            co = Company.find(trans.company_id)
            self.stock_position(co.ticker)
        end.uniq

        #output #=> ##array of hashes [{ticker: AAPL, shares: 3, total_value: 30}, {ticker: MMM, shares: 90, total_value: 9000}

    end

    def unrealized_gain
        #update initial purchases on seed file so that the current price is (hopefully lower) different than the purchase price
    end

    private
    def execute_transaction(tckr, quantity, is_purchase)
        company = Company.find_by(ticker: tckr.upcase)
        today = Time.now
        x = Transaction.find_or_create_by(investor_id: self.id, company_id: company.id, transaction_date: today, price: company.current_price, quantity: quantity, is_purchase?: is_purchase)
        x.save
    end
end
