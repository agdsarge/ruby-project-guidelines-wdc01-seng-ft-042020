
def broker_help
    system("clear")
    puts "\n\n\n\n\n\n"
    puts "          quit"
    puts "            - this command will logout a user."
    puts "\n"
    puts "          clients" #print all client names in a numbered list
    puts "            - this command will print all client names in a numbered list."
    puts "\n"
    puts "          quote" # that i own
    puts "            - this command will print a position of a single equity."
    puts "            * require a company's ticker"
    puts "\n"
    puts "          portfolio" #print all positions
    puts "            - this command will print all positions."
    puts "\n"
    puts "          deposit"  #deposit (monopoly money!)
    puts "            - this command will allow you to deposit money."
    puts "            * require an amount to deposit."
    puts "\n"
    puts "          withdraw"  # withdraw (sad times!)
    puts "            - this command will allow you to withdraw money."
    puts "            * require an amount to withdraw."
    puts "\n"
    puts "          broker"   #broker inquiry
    puts "            - this command will allow you to see your broker's contact information."
    puts "\n"
    puts "          trade" #direct broker to action
    puts "            - this command will allow you to request your broker's assistance to buy and sell shares."
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

def quote(invstr, tckr)
    stock_hash = invstr.stock_position(tckr)
    total_two_digits = stock_hash[:total_value]


    puts "\n\n\n"
    puts "          Here is your position for #{stock_hash[:ticker].upcase}."
    puts "          You hold #{stock_hash[:shares]} shares."
    puts "          The current market value of your shares is $#{'%.2f' % total_two_digits}"

    gets
end

def quote_print(stk_hsh)
    total_two_digits = stk_hsh[:total_value]
    puts "\n\n"
    puts "          Here is your position for #{stk_hsh[:ticker].upcase}."
    puts "          You hold #{stk_hsh[:shares]} shares."
    puts "          The current market value of your shares is $#{'%.2f' % total_two_digits}"
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
    Broker.find_or_create_by(first_name: fname, last_name: lname, username: uname, password: pword, email: email, telephone: tele)
    gets
    system("clear")
    puts "\n\n\n\n\n\n"
    puts "          New account creation successful.\n\n"
    puts "          Please welcome #{fname} to their new job at Pittaluga et Sargeant."
    gets
end

def purchase_stock(brkr)
    print "          If you know the invetor's ID number, please enter it now."
    inv_id = gets.chomp.to_i
    print "          Please enter the company's ticker"
    tckr = gets.chomp.upcase
    print "          How many shares should will be purchased?"
    qty = gets.chomp.to_i
    brkr.buy_stock_for_investor(inv_id, tckr, qty) #error handle later
    gets
    puts "          Purchase successful."
gets
end
# def buy_stock_for_investor(investor_id, tckr, quantity)
#     inv = Investor.find(investor_id)
#     raise "This investor is not your personal client" unless self.id == inv.broker_id
#     inv.buy_stock(tckr, quantity)
# end


def sell_stock(brkr)

gets
end



def display_broker_info(invstr)
    arr = invstr.get_broker_contact

    puts "\n\n\n\n\n\n"
    puts "          Your friendly broker is: #{arr[0]}"
    puts "          Their telephone number is: #{arr[1]}"
    puts "          Their email address is: #{arr[2]}"

    gets
end

def cash_balance(invstr)
    puts "\n\n\n"
    invstr = Investor.find(invstr.id)
    print "          You have $#{'%.2f' % invstr.account_cash} available."
    gets
end

def deposit_method(invstr)
    puts "\n\n\n\n\n\n"
    print "          How much would you like to deposit today?:  "
    amount = gets.chomp
    invstr.add_cash(amount.to_f)
    puts "          Your deposit has gone through."
    print "          You have $#{'%.2f' % invstr.account_cash} available."
    gets
end

def withdraw_method(invstr)
    puts "\n\n\n\n\n\n"
    print "          How much would you like to withdraw today?:  "
    amount = gets.chomp.to_f
    if amount < invstr.account_cash
        invstr.withdraw_cash(amount)
        puts "          Your withdrawl has been transferred to your linked account."
        print "          You have $#{'%.2f' % invstr.account_cash} available."
    else
        puts "          You cannot overdraw this account."
        puts "          You have $#{'%.2f' % invstr.account_cash} available."
        puts "          Please withdraw a valid amount."
    end
    gets
end

def direct_broker(invstr) #direct broker to action
    puts "\n\n\n\n\n\n"
    print "          Would you like to buy or sell today?:  "
    cmd = gets.chomp

    case cmd
    when (/^buy$/i)
        puts "\n\n\n"
        print "          What stock would you like to buy? (Please provide ticker):  "
        tckr = gets.chomp
        puts "\n\n\n"
        print "          How many shares would you like to buy?:  "
        qty = gets.chomp
        invstr.broker.buy_stock_for_investor(invstr.id, tckr, qty.to_i)
        cash_balance(invstr)
    when (/^sell$/i)
        puts "\n\n\n"
        print "          What stock would you like to sell today? (Please provide ticker):  "
        tckr = gets.chomp
        puts "\n\n\n"
        print "          How many shares would you like to sell?:  "
        qty = gets.chomp
        invstr.broker.sell_stock_for_investor(invstr.id, tckr, qty.to_i)
        cash_balance(invstr)
    when "(/^cancel$/i)"
        print "          Request cancelled."
    else
        print "          Invalid Command."
        gets
        direct_broker(invstr)
    end
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
        when(/^new company$/i) ### TODO
            new_company(brkr)
        when(/^purchase stock$/i)
            purchase_stock(brkr)
        when(/^sell stock$/i)
            sell_stock(brkr)

            #################
        when (/^quote$/i) #print a position of a single equity that i own tested
            print "          Do you know the company ticker?:  "
            tckr = gets.chomp
            quote(brkr, tckr)
        when (/^balance$/i) #print cash balace
            cash_balance(brkr)

        when (/^deposit$/i)  #deposit (monopoly money!) #tested
            deposit_method(brkr)
        when (/^withdraw$/i) # withdraw (sad times!) valid deposit / overdraw tested.
            withdraw_method(brkr)
        when (/^broker$/i)  #broker inquiry tested
            display_broker_info(brkr)
        when (/^trade$/i) #direct broker to action #tested
            direct_broker(brkr)
        when (/^quit$/i)   #logout tested many many times
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
