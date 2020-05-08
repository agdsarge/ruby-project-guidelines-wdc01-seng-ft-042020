def broker_help
    system("clear")
    puts "\n\n\n\n\n\n"
    puts "          quit"
    puts "            - this command will logout a user."
    puts "\n"
    puts "          clients" #print all client names in a numbered list
    puts "            - this command will print all client names in a numbered list."
    puts "\n"
    puts "          portfolio" #print all positions
    puts "            - this command will print all positions."
    puts "\n"
    puts "          update" #print all positions
    puts "            - this command will provide PetS with the latest market prices."
    puts "\n"
    puts "          companies" #print all positions
    puts "            - this displays all companies tracked by PetS."
    puts "\n"
    puts "          purchase stock"  #deposit (monopoly money!)
    puts "            - this command will allow you to buy stock for an investor."
    puts "            * require an investor id, stock ticker, and a number of shares to purchase."
    puts "\n"
    puts "          sell stock"  # withdraw (sad times!)
    puts "            - this command will allow you to sell stock for an investor."
    puts "            * require an investor id, stock ticker, and a number of shares to sell."
    puts "\n"
    puts "          new investor"   #new client
    puts "            - this command will allow you to create a new client."
    puts "            * require a first name, last name, username, password, and an initial deposit."
    puts "\n"
    puts "          new company"   #new company to track
    puts "            - this command will allow you to see your broker's contact information."
    puts "            * require a ticker and name."
    puts "\n"
    puts "          new broker"   #new broker
    puts "            - this command will allow you to create a new broker."
    puts "            * require a first name, last name, username, password, email and a telephone number."
    puts "\n"
    gets

end

def logout
    system("clear")
    puts "\n\n\n\n\n\n"
    puts "          Goodbye!"
    gets

end

def client_list(brkr)
    new_idea = brkr.investors #an array of invsestor instances
    puts "\n\n\n"
    new_idea.each_with_index {|c, i| puts "          #{i+1}. #{c.first_name} #{c.last_name} ID: #{c.id}"}
    gets
end

def br_portfolio_method(brkr)
    puts "\n\n\n\n"
    x = brkr.get_portfolio_of_all_clients
    total_funds_managed = 0
    x.each_with_index do |investor, i|
        inv_obj = Investor.find(investor.keys[0])
        puts "          #{i+1}. #{inv_obj.first_name} #{inv_obj.last_name}"

        investor.values.each do |arr|
            arr.each do |elem|
                total = '%.2f' % elem[:total_value]
                puts "                    The current position in #{elem[:ticker]} is #{elem[:shares]} shares valued at $#{total}."
                total_funds_managed += elem[:total_value]
            end
        end
        gets
    end
    # you manage x amount of money
    total_funds_managed = '%.2f' % total_funds_managed
    puts "          The total value of the portfolio managed is $#{total_funds_managed}"
    gets
end

def new_investor(brkr)
    check_state = false
    while check_state == false
        system("clear")
        puts "\n\n\n"
        print "          First name:      "
        fname = gets.chomp
        print "          Last name:       "
        lname = gets.chomp
        print "          username:        " #validate username
        uname = gets.chomp
        print "          password:        "
        pword = gets.chomp
        print "          Initial Deposit: "
        acc_cash = gets.chomp.to_f
        valid_obj = {first_name: fname, last_name: lname, username: uname, password: pword, account_cash: acc_cash }
        check_state = Validation.validate?(valid_obj)
    end
    brkr.create_new_client(fname, lname, uname, pword, acc_cash)
    gets
    system("clear")
    puts "\n\n\n\n\n\n"
    puts "          New account creation successful.\n\n"
    if acc_cash < 1000000.0
        puts "          Please welcome #{fname} to Pittaluga et Sargeant."
    else
        puts "          The new client is a high-roller. Give them the red-carpet treatment."
    end
    gets
end

def new_broker(brkr)
    check_state = false
    while check_state == false
        system("clear")
        puts "\n\n\n"
        print "          First name:      "
        fname = gets.chomp
        print "          Last name:       "
        lname = gets.chomp
        print "          username:        " #validate username
        uname = gets.chomp
        print "          password:        "
        pword = gets.chomp
        print "          Email:           "
        email = gets.chomp
        print "          Telephone:       "
        tele = gets.chomp
        valid_obj = {first_name: fname, last_name: lname, username: uname, password: pword, email: email}
        check_state = Validation.validate?(valid_obj)
    end
    Broker.find_or_create_by(first_name: fname, last_name: lname, username: uname, password: pword, email: email, telephone: tele)
    gets
    system("clear")
    puts "\n\n\n\n\n\n"
    puts "          New account creation successful.\n\n"
    puts "          Please welcome #{fname} to their new job at Pittaluga et Sargeant."
    gets
end

def purchase_stock(brkr)
    check_state = false
    while check_state == false
        print "          If you know the investor's ID number, please enter it now: "
        inv_id = gets.chomp.to_i
        print "          Please enter the company's ticker: "
        tckr = gets.chomp.upcase
        print "          How many shares should will be purchased?: "
        qty = gets.chomp.to_i
        #refresh_all_prices(brkr)
        check_state = Validation.validate?({id: inv_id, ticker:tckr})
    end
    result = brkr.buy_stock_for_investor(inv_id, tckr, qty) #error handle later
    if result
        puts "\n\n\n"
        puts "          Purchase successful."
        gets
    else
        puts "\n\n\n"
        puts "          There has been an error processing your request. The client has insufficient funds in his account."
        gets
    end
end

def new_company(brkr)

    check_state = false

    while check_state == false
        system("clear")
        puts "\n\n\n\n\n\n"
        print "          What is the ticker of the company that PetS will track?: "
        tckr = gets.chomp.upcase

        url = 'https://cloud.iexapis.com/stable'
        end_point = "/stock/#{tckr.downcase}/batch?"
        query_string = "types=quote&"

        composite_url = "#{url}#{end_point}#{query_string}token=#{TOKEN}"


        if Validation.validate?({ticker: tckr}) && Validation.validate_api(composite_url)[0]

            response = Validation.validate_api(composite_url)

            check_state = response[0]
        else
            puts "\n\n\n"
            puts "          Please enter an alphanumeric ticker symbol."
            gets
        end
    end
    new_c = brkr.create_new_company(tckr)
    puts "          PetS now tracks #{new_c.name}"
    gets
end

def refresh_all_prices(brkr)
    puts "\n\n\n\n"
    brkr.update_all_prices
    puts "          PetS now knows the most recent prices of all tracked securities."
    gets
end

def list_all_companies(brkr)
    system("clear")
    puts "\n\n\n\n"
    puts "          PetS specializes in the following companies: "
    puts "\n\n"
    brkr.get_companies.each {|arr| puts "          #{arr[1]} - #{arr[0]}"} #arr of arr
    gets
end


def sell_stock(brkr)
    print "          If you know the investor's ID number, please enter it now: "
    inv_id = gets.chomp.to_i
    print "          Please enter the company's ticker: "
    tckr = gets.chomp.upcase
    print "          How many shares should will be sold?: "
    qty = gets.chomp.to_i
    #refresh_all_prices(brkr)
    brkr.sell_stock_for_investor(inv_id, tckr, qty) #error handle later
    gets
    puts "          Sale successful."

gets
end


def launch_broker_interface(brkr)
    while true
        system("clear")
        puts "\n\n\n\n\n\n"
        puts "          User: #{brkr.first_name} #{brkr.last_name}"
        puts "          Enter 'help' for your options"
        puts "\n\n\n"
        print "          "
        input = gets.chomp

        case input
        when (/^h$|help/i) #help
            puts ""
            broker_help
        when (/^clients$/i) #
            client_list(brkr)
        when (/^portfolio$/i) #print all positions of all clients related to the logged-in borker
            br_portfolio_method(brkr)
        when (/^new investor$/i)
            new_investor(brkr)
        when (/^new broker$/i)
            new_broker(brkr)
        when(/^new company$/i)
            new_company(brkr)
        when(/^companies$/i)
            list_all_companies(brkr)
        when(/^purchase stock$/i)
            purchase_stock(brkr)
        when(/^update$/i)
            refresh_all_prices(brkr)
        when(/^sell stock$/i)
            sell_stock(brkr)
        when (/^quit$/i)   #logout tested many many times
            logout
            break
        when (/^exit$/i)   #logout tested many many times
            logout
            break
        else
            puts "\n\n\n"
            puts "          I don't recognize that command!"
            puts "          Here's a bit of help!"
            gets
            broker_help
        end




    end

end
