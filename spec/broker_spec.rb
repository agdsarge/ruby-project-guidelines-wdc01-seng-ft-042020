# require_relative '../config/environment.rb'
require 'active_record'
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil
require 'rest-client'
Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}

# require_relative '../app/models/broker.rb'

describe Broker do

    let (:spam) {Broker.new}
      it "message for test" do
         expect(spam.update_all_prices).to be(true)
      end

end
