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
        puts lowest_id
        highest_id = Investor.last.id
        puts highest_id

        obj.each do |key, value|

            case key

            when :name
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
            puts '\n\n\n\n\n\n'
            puts "          There was a problem with your API call. Error: #{err.response}"
            return [false, err.response]
          else
            puts 'It worked!'
            return [true, resp]
          end

    end


end

