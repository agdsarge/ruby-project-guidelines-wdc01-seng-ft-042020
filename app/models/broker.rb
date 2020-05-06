class Broker < ActiveRecord::Base
    has_many :investors

    # Class Methods

    def self.pets_clients
        self.all.map {|brkr| brkr.investors}
    end


    #Instance Methods

    #class method all brokers all clients. assigns to self
    def create_new_client(fname, lname, uname, pword, cash)
        Investor.create_or_find_by(first_name: fname, last_name: lname, username: uname, password: pword, broker_id: self.id, account_cash: cash)#look up hashing
    end

    def get_portfolio
        # return array of hashes
        self.investors.map do |investor|
            {investor.id => investor.all_positions}
        end
        # Desired Output  [{client_id => [] } {client_id => []}]
    end

    def get_client_portfolio(client_id)

    end

    def get_investors_by_first_name(fname)
        fname.capitalize!
        my_guys = self.investors.select {|inv| inv.first_name == fname}
        my_guys.map {|inv| [inv.first_name, inv.last_name, inv.id]}
        #return [fname, lname, investor_id]
    end


end
