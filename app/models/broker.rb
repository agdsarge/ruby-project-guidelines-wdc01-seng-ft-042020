class Broker < ActiveRecord::Base
    has_many :investors

    # Class Methods

    def self.pets_clients
        #all clients of the firm
        self.all.map {|brkr| brkr.investors}
    end

    #Instance Methods


    def create_new_client(fname, lname, uname, pword, cash)
        #class method all brokers all clients. assigns to self
        #make sure username will be unique
        Investor.create_or_find_by(first_name: fname, last_name: lname, username: uname, password: pword, broker_id: self.id, account_cash: cash)#look up hashing
    end

    def get_portfolio_of_all_clients
        # return array of hashes
        self.investors.map do |investor|
            {investor.id => investor.all_positions}
        end
        # Desired Output  [{client_id => [] } {client_id => []}]
    end

    def get_investor_portfolio(investor_id)
        inv = Investor.find(investor_id)
        raise "This investor is not your personal client" unless self.id == inv.broker_id
        inv.all_positions
    end

    def get_investors_by_first_name(fname)
        fname.capitalize!
        my_guys = self.investors.select {|inv| inv.first_name == fname}
        my_guys.map {|inv| [inv.first_name, inv.last_name, inv.id]}
        #return [fname, lname, investor_id]
    end

    def buy_stock_for_investor(investor_id, tckr, quantity)
        inv = Investor.find(investor_id)
        raise "This investor is not your personal client" unless self.id == inv.broker_id
        inv.buy_stock(tckr, quantity)
    end

    def sell_stock_for_investor(investor_id, tckr, quantity)
        inv = Investor.find(investor_id)
        raise "This investor is not your personal client" unless self.id == inv.broker_id
        inv.sell_stock(tckr, quantity)
    end


end
