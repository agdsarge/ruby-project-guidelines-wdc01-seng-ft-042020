class Validation

    def self.print_invalid(type)
        system('clear')
        puts "\n\n\n\n\n\n\n\n"
        puts "            Invalid #{type.to_s}. Please try again."
        gets
    end


    def self.validate?(obj)

        # {:name => "Enrique", :id => 12, :account_cash => 3.99 }
        lowest_id = Investor.first.id
        highest_id = Investor.last.id

        obj.each do |key, value|

            case key
            when :first_name
                if value.class != String
                    self.print_invalid(key)
                    return false
                end
            when :last_name
                if value.class != String
                    self.print_invalid(key)
                    return false
                end
            when :id
                if value.class != Integer || value < lowest_id || value > highest_id
                    self.print_invalid(key)
                    return false
                end
            when :account_cash
                if (value.class != Float && value.class != Integer)
                    self.print_invalid(key)
                    return false
                end
            when :ticker
                if value.class != String || value.match?(/[^a-z0-9]/i)
                    self.print_invalid(key)
                    return false
                end
            else
                return false
            end

        end
        return true
    end

    def self.validate_api(url)

        begin
            resp = RestClient.get(url)

        rescue RestClient::ExceptionWithResponse, RestClient::Unauthorized, RestClient::Forbidden => err
            system('clear')
            puts "\n\n\n\n\n\n"
            puts "          There was a problem with your API call. Error: #{err.response}"
            gets
            return [false, err.response]
        else
            json = JSON.parse(resp)
            if json["quote"].nil?
                system('clear')
                puts "\n\n\n\n\n\n"
                puts "          There was a problem with your API call. Error: Ticker no longer valid"
                gets
                return [false, resp]
            else
                return [true, resp]
            end
        end

    end


end
