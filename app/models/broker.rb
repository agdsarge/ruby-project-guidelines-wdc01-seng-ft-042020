class Broker < ActiveRecord::Base
    has_many :investors

    #class method all brokers all clients. assigns to self
    def create_new_client(fname, lname, uname, pword, cash)
        Investor.create_or_find_by(first_name: fname, last_name: lname, username: uname, password: pword, broker_id: self.id, account_cash: cash)#look up hashing
    end

    def self.pets_clients
        self.all.map {|brkr| brkr.investors}
    end
end
