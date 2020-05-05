class Broker < ActiveRecord::Base
    has_many :investors

    #def method


    #class method all brokers all clients

    def self.pets_clients
        self.all.map {|brkr| brkr.investors}
    end
end
