require_relative '../../tokensandkeys.rb'

class Broker < ActiveRecord::Base
    has_many :investors

    # Class Methods

    def self.pets_clients
        #all clients of the firm
        self.all.map {|brkr| brkr.investors}
    end

    #Instance Methods

    def update_all_prices
        #api
        #url
        tckrlist = self.get_companies.map { |elem_arr| elem_arr[1] }
        tckr_list_string = tckrlist.join(",").downcase
        url = 'https://cloud.iexapis.com/stable'
        end_point = '/stock/market/batch'
        query_string = "?symbols=#{tckr_list_string}&types=quote&"
        #token = 'pk_5cd3b7f4dbb54f5e8a29a3474057fb68'

        composite_url = "#{url}#{end_point}#{query_string}token=#{TOKEN}"
        response = RestClient.get(composite_url)
        #response = Validation.validate_api(composite_url)
        #endpoints
        #querystring => transform some array of companytickers into string separated by commas

        #parse with json

        json = JSON.parse(response)

        json.each do |k, v|
                value = v["quote"]["latestPrice"]

                stock = Company.find_by(ticker: k.upcase)
                stock.current_price = value
                stock.save
            end
        return true
    end

    # def stock_valid?(resp)
    #     if response[1]
    #         return true #or false
    #     else
    #         return
    #     end
    # end

    def update_stock_price(tckr)
        #return a float with current price

        #api
        url = 'https://cloud.iexapis.com/stable'
        end_point = "/stock/#{tckr.downcase}/batch?"
        query_string = "types=quote&"

        composite_url = "#{url}#{end_point}#{query_string}token=#{TOKEN}"

        response = Validation.validate_api(composite_url)
        # stock_valid(response)
        #url
        #endpoints
        #querystring => transform some array of companytickers into string separated by commas

        #parse with json

        json = JSON.parse(response[1])

        #pp json["quote"]

        return [json["quote"]["companyName"], json["quote"]["latestPrice"]]


    end

    def create_new_company(tckr)
        comp_arr = update_stock_price(tckr) #[name, price]
        Company.find_or_create_by(ticker: tckr.upcase, name: comp_arr[0], current_price: comp_arr[1])
    end

    def get_companies #tested
        #returns Array of Arrays name is [0], ticker is [1]
        Company.all.pluck(:name, :ticker, :current_price)
    end

    def get_investor_clients
        x = Investor.all.pluck(:first_name, :last_name, :broker_id, :id)
        return x.select {|i_arr| i_arr[2] == self.id}
    end

    def create_new_client(fname, lname, uname, pword, cash)
        #class method all brokers all clients. assigns to self
        #make sure username will be unique
        Investor.find_or_create_by(first_name: fname, last_name: lname, username: uname, password: pword, broker_id: self.id, account_cash: cash) #look up hashing
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
