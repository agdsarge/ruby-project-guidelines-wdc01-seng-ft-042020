def investor_help
    system("clear")
    puts "\n\n\n\n\n\n"
    puts "          quit"
    puts "            - this command will logout a user."
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

def portfolio_method(invstr)
    x = invstr.all_positions

    x.each {|sh| quote_print(sh)}
    y = x.map {|sh| sh[:total_value]}.sum
    y = '%.2f' % y
    puts "          Your total investment holdings amount to $#{y}"
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
        #invstr.broker.refresh_all_prices
        invstr.broker.buy_stock_for_investor(invstr.id, tckr, qty.to_i)
        cash_balance(invstr)
    when (/^sell$/i)
        puts "\n\n\n"
        print "          What stock would you like to sell today? (Please provide ticker):  "
        tckr = gets.chomp
        puts "\n\n\n"
        print "          How many shares would you like to sell?:  "
        qty = gets.chomp
        #invstr.broker.refresh_all_prices
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

def launch_investor_interface(invstr)
    while true
        system("clear")
        puts "\n\n\n\n\n\n"
        puts "          Please type a command for PetS to execute"
        puts "          If you are unsure, enter 'help' for your options"
        puts "\n\n\n"
        print "          "
        input = gets.chomp

        case input
        when (/^h$|help/i) #help tested
            puts ""
            investor_help
        when (/^quote$/i) #print a position of a single equity that i own tested
            print "          Do you know the company ticker?:  "
            tckr = gets.chomp
            quote(invstr, tckr)
        when (/^balance$/i) #print cash balace
            cash_balance(invstr)
        when (/^portfolio$/i) #print all positions tested
            portfolio_method(invstr)
        when (/^deposit$/i)  #deposit (monopoly money!) #tested
            deposit_method(invstr)
        when (/^withdraw$/i) # withdraw (sad times!) valid deposit / overdraw tested.
            withdraw_method(invstr)
        when (/^broker$/i)  #broker inquiry tested
            display_broker_info(invstr)
        when (/^trade$/i) #direct broker to action #tested
            direct_broker(invstr)
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
            investor_help
        end




    end

end
