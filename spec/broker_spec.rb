# require_relative '../config/environment.rb'
require 'active_record'
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil
require 'rest-client'
Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}

# require_relative '../app/models/broker.rb'

describe Broker do

    after(:each) do
        Broker.destroy_all
    end

    before(:each) do
        @gb = Broker.find_or_create_by(first_name: "George", last_name: "Banks", username: "gbanks", password: "poppins", email: "gbanks@pets.com", telephone: "777-555-7654")
        @burns = Broker.find_or_create_by(first_name: "Montgomery", last_name: "Burns", username: "mtburns", password: "springfield", email: "mtburns@pets.com", telephone: "818-404-9009")
        @pn = Broker.find_or_create_by(first_name: "Paul", last_name: "Nicholsen", username: "pnicholsen", password: "iluvcats", email: "pnicholsen@pets.com", telephone: "202-555-7654")
        @sn = Broker.find_or_create_by(first_name: "Shannon", last_name: "Nabors", username: "snabors", password: "pictionary", email: "snbabors@pets.com", telephone: "202-555-0798")

    end

    let (:spam) {Broker.new}

    describe "attributes" do
        it "has data attributes given to it from a migration file" do
            expect(@sn.first_name).to eq("Shannon")
            expect(@pn.last_name).to eq("Nicholsen")
            expect(@burns.username).to eq("mtburns")
            expect(@gb.email).to eq("gbanks@pets.com")
        end
    end

    it "returns true after updating all current prices for the Company table" do
        expect(spam.update_all_prices).to be(true)
    end

    it "returns an array with get companies" do
        expect(spam.get_companies[0].class).to eq(Array)
    end

end
